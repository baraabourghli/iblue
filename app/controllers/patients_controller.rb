class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.all.order(:score)
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  def about
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_patient
    age, pulse, respiratory = rand(16..100),rand(10..180),rand(50..200)


    sagemaker = Aws::SageMakerRuntime::Client.new(
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-southeast-1'
    )
    # [Age, Respiratory, Pulse]
    response = sagemaker.invoke_endpoint(endpoint_name: "sagemaker-tensorflow-2020-04-26-13-17-53-430",
                                        content_type: 'application/json',
                                        body: "[[#{age}, #{respiratory}, #{pulse}]]")

    score = JSON.parse(response[:body].string)["outputs"]["score"]["floatVal"].first * 100
    
    severity = ''
    case score
    when 0..20
      severity = 'Critical'
    when 20..40
      severity = 'Severe'
    when 40..60
      severity = 'Moderate'
    else
      severity = 'Mild'
    end

    @patient = Patient.new(age: age, pulse: pulse, respiratory: respiratory, score: score, severity: severity)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:score, :score, :severity, :pulse, :age, :respiratory)
    end
end
