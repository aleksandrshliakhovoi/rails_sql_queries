class N1Controller < ApplicationController
  def index
    @n1 = Branch.all.map{|br| br.feedbacks} #Organization.all.map{|org| org.branches }
  end
end