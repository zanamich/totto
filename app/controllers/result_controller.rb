class ResultController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index

    Resque.enqueue(FormGenerator, :create_permutations, { 'form_structure' => [4,7,5],
                                                          'bankers' => { 0 => '1',
                                                                         3 => 'X',
                                                                         4 => '1',
                                                                         7 => '2',
                                                                         8 => '2',
                                                                         10 => 'X',
                                                                         13 => '1'
                                                                        },
                                                          'index' => 0,
                                                          'form' => %w(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
                                                        })

    render 'result/index'
  end
end
