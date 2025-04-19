class TrabajosController < ApplicationController
  before_action :set_trabajo, only: %i[ show edit update destroy ]

  # GET /trabajos or /trabajos.json
  def index
    if params[:query].present?
      @clientes_con_trabajos = Cliente.joins(:trabajos)
        .where("clientes.nombre ILIKE ? OR trabajos.tipo ILIKE ? OR CAST(trabajos.id AS TEXT) ILIKE ?", *[ "%#{params[:query]}%" ]*3)
        .distinct
        .includes(:trabajos)
    else
      # Solo mostrar clientes con trabajos
      @clientes_con_trabajos = Cliente.joins(:trabajos).distinct.includes(:trabajos).order(:nombre)
    end
  end

  # GET /trabajos/1 or /trabajos/1.json
  def show
  end

  # GET /trabajos/new
  def new
    @trabajo = Trabajo.new
  end

  # GET /trabajos/1/edit
  def edit
  end

  # POST /trabajos or /trabajos.json
  def create
    cliente_nombre = trabajo_params[:cliente_nombre]&.strip
    cliente = Cliente.find_or_create_by(nombre: cliente_nombre) if cliente_nombre.present?

    @trabajo = Trabajo.new(trabajo_params.except(:cliente_nombre))
    @trabajo.cliente = cliente if cliente

    respond_to do |format|
      if @trabajo.save
        format.html { redirect_to @trabajo, notice: "Trabajo creado exitosamente." }
        format.json { render :show, status: :created, location: @trabajo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trabajo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    cliente_nombre = trabajo_params[:cliente_nombre]&.strip
    cliente = Cliente.find_or_create_by(nombre: cliente_nombre) if cliente_nombre.present?

    respond_to do |format|
      if @trabajo.update(trabajo_params.except(:cliente_nombre))
        @trabajo.update(cliente: cliente) if cliente
        format.html { redirect_to @trabajo, notice: "Trabajo modificado exitosamente." }
        format.json { render :show, status: :ok, location: @trabajo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trabajo.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /trabajos/1 or /trabajos/1.json
  def destroy
    @trabajo.destroy!

    respond_to do |format|
      format.html { redirect_to trabajos_path, status: :see_other, notice: "Trabajo eliminado exitosamente." }
      format.json { head :no_content }
    end
  end

  def toggle_pagado
    @trabajo = Trabajo.find(params[:id])
    @trabajo.update(pagado: !@trabajo.pagado)
    redirect_to trabajos_path, notice: "Estado de pago actualizado."
  end


  private

    # Use callbacks to share common setup or constraints between actions.
    def set_trabajo
      @trabajo = Trabajo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trabajo_params
      params.require(:trabajo).permit(:tipo, :caracteristicas, :valor, :pagado, :cliente_id, :cliente_nombre)
    end
end
