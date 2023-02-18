class BranchesController < ApplicationController
  def create
    @brnch = Organization.first.branches.new(name: Faker::Games::HalfLife.location)

    if @brnch.save
      redirect_to organizations_path
    end
  end
end
