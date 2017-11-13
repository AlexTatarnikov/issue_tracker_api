class Api::V1::BaseController < ApplicationController
  private

  def respond_with_success(object, options={})
    respond_with(:api, :v1, object, {root: 'data', status: 200}.merge(options))
  end

  def respond_with_error(object, options={})
    respond_with(:api, :v1, object, {status: 422, serializer: ActiveModel::Serializer::ErrorSerializer}.merge(options))
  end
end
