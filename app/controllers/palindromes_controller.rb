class PalindromesController < ApplicationController
  before_action :check_num, only: :result


  def index
  end

  def result
    redirect_to '/' unless flash.empty?
    p flash[:notice]
    return unless flash.empty?
    @result = count_result(params[:number].to_i)

    i = -1
    @xml_arr = Array.new(@result.size) do
      i += 1 
      {index: i + 1, def: @result[i][0], sqr: @result[i][1]}
    end

    respond_to do |format|
      format.html
      format.xml { render :xml => @xml_arr
      p "!!" }
    end
  end

  private 

  def check_num
    number = params[:number]
    return if number.nil?
    if Integer(number, exception: false).nil?
      flash[:notice] = "'#{number}' не является числом"
      return
    end
    if number.to_i <= 0  then
      flash[:notice] = "Вы ввели: '#{number}' Введите число, больше 0."
    end
  end

  def palindrome?(str)
    str == str.reverse
  end

  def count_result(number)
    (1..number).each.select { |num| if palindrome?(num.to_s) && palindrome?((num**2).to_s) then num end }.map { |i| [i, i**2] }
  end
end
