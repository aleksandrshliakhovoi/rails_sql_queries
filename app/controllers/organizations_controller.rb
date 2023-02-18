class OrganizationsController < ApplicationController
  def index
    @orgs = Organization.all
    @org_first_branches = Organization.first.branches
  end

  def create
    @org = Organization.new(name: Faker::Games::ElderScrolls.region)

    if @org.save
      redirect_to organizations_path
    end
  end
end
