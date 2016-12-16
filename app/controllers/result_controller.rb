class ResultController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index

    Resque.enqueue(FormGenerator)

    render 'result/index'
  end
end
