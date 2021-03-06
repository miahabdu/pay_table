class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /accounts
  # GET /accounts.json
  def index
    @current_accounts = Account.by_user(current_user.id).for_current_month.order(sort_column + " " + sort_direction)
    @future_accounts = Account.by_user(current_user.id).for_next_month
    @previous_accounts = Account.by_user(current_user.id).for_last_month.order("due_date desc").page(params[:page]).per_page(10)
    @account = Account.new
    # render partial: 'row', account: Account.last
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    # if account_params[:due_date]
      
    # end
    

    # respond_to do |format|
    #   if @account.save
    #     format.html { redirect_to @account, notice: 'Account was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @account }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @account.errors, status: :unprocessable_entity }
    #   end
    if @account.save
      @account.update_attributes(due_date_month: account_params[:due_date].to_date.month, 
                                  due_date_year: account_params[:due_date].to_date.year,
                                  user_id: current_user.id)

      render 'success_add'
    else
      render 'failure'
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        if account_params[:due_date]
          month = account_params[:due_date].to_date.month.to_s
          year = account_params[:due_date].to_date.year.to_s
          @account.update_attributes(due_date_month: month, due_date_year: year)
        end

        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { respond_with_bip(@account) }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.js { render "destroy"}
    end
  end

  def account_totals
    totals = AccountTotals.new(Account.by_user(current_user.id)).totals

    render :json => totals.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(account_columns)
    end
    def account_columns
      cols = Account.columns.map(&:name).map(&:to_sym) 
      cols - [:created_at, :updated_at]
    end

    def sort_column
      Account.column_names.include?(params[:sort]) ? params[:sort] : "due_date"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
