class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.order(sort_column + " " + sort_direction)
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

    # respond_to do |format|
    #   if @account.save
    #     format.html { redirect_to @account, notice: 'Account was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @account }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @account.errors, status: :unprocessable_entity }
    #   end
    if @account.save
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
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
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
