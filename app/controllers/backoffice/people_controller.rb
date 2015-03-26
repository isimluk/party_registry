class Backoffice::PeopleController < ApplicationController

  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authorize_backoffice

  autocomplete :person, :email, :display_value => :email_name_id_region, :extra_data => [:name_prefix, :first_name, :last_name, :name_suffix, :domestic_region_id]
  autocomplete :person, :last_name, :display_value => :name_id_region, :extra_data => [:name_prefix, :first_name, :last_name, :name_suffix, :domestic_region_id]

  # GET /people
  # GET /people.json
  def index
    @people = Person.paginate(page: params[:page], per_page: 10)
  end

  def with_unknown_address
    @people = Person.includes([:domestic_ruian_address]).select{|p| p.domestic_ruian_address.nil?}
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to :back, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:domestic_address_ruian_id)
    end

    def authorize_backoffice
      authorize!(:backoffice, :all)
    end
end
