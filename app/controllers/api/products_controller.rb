class Api::ProductsController < ActionController::API
  before_action :set_product, only: [:show, :update]

  def index

    @products = Product.all
    render json: @products

  end

  def show

    render json: {data: @product, status: :ok, message: 'Success'}

  end

  def update

    if @product.update(product_params)
      render json: {status: :ok, message: 'Producto Actualizado'}
    else
      render json: {json: @product.errors, status: :unprocessable_entity}
    end

  end

  def create

    @product = Product.new(product_params)
    if @product.save
      render json: {status: :ok, message: 'Success'}
    else
      render json: {json: @product.errors, status: :unprocessable_entity}
    end

  end

  def destroy

    @product = Product.find(params[:id])
    if @product.destroy
      render json: {json: 'El producto se borró exitosamente'}
    else
      render json: {json: @product.errors, status: :unprocessable_entity}
    end

  end

  private

  def set_product
    @product = Product.find(product_params[:id])
  end

  def product_params
    params.require(:product).permit(:id, :nombre, :precio, :cantidad, :stock, :description)
  end
end
