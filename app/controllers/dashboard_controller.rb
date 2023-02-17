require 'json'

class DashboardController < ApplicationController
  def index
    first_task
    second_task
    third_task
    fourth_task
    fifth_task
    stats
    high_load_db_with_error
    # error_here
  end

  private

  def stats
    @branches_size = Branch.all.size
    @orgs_size = Organization.all.size
    @feedbacks_size = Feedback.all.size
  end

  def first_task
    @first = Branch.where(name: 'Branch REWE 05')
                   .joins(:feedbacks)
                   .group(:name)
                   .count
  end

  def second_task
    @second = Organization.where(name: 'Fitx')
                          .joins(branches: :feedbacks)
                          .group(:quality)
                          .count
                          .sort
  end

  def third_task
    @third = Organization.where(name: 'Douglas')
                         .joins(branches: :feedbacks)
                         .group(:quality, :age_group)
                         .count
                         .sort
  end

  def fourth_task
    @fourth = Organization.where(name: 'BMW')
                          .joins(branches: :feedbacks)
                          .group('branches.name')
                          .average(:quality)
                          .sort

    # @fourth = Organization.find_by_sql(
    #   'SELECT AVG(quality) as avg_quality, branches.name
    #   FROM organizations
    #   JOIN branches on organizations.id = branches.organization_id
    #   JOIN feedbacks on branches.id = feedbacks.branch_id
    #   WHERE organizations.name = "BMW"
    #   GROUP BY branches.name
    #   ORDER BY avg_quality desc'
    # )
  end

  def fifth_task
    results = Organization.find_by_sql(
      'SELECT COUNT(*) as count, feedbacks.nps as nps, organizations.name as name
      FROM organizations
      JOIN branches on organizations.id = branches.organization_id
      JOIN feedbacks on branches.id = feedbacks.branch_id
      GROUP BY organizations.name, feedbacks.nps'
    )

    # this is the same like previous
    results_by_act_record = Organization.joins(branches: :feedbacks)
                                        .select('COUNT(*) as count, organizations.id, feedbacks.nps as nps, organizations.name as name')
                                        .group('organizations.id', 'organizations.name', 'feedbacks.nps')

    hash1 = {}
    hash2 = {}

    results.each do |company|
      key = company.name
      hash1[key] = { total: 0, promoters: 0, detractors: 0 } if hash1[key].blank?

      if company.nps <= 6
        hash1[key][:detractors] += company.count
      elsif company.nps >= 9
        hash1[key][:promoters] += company.count
      end

      hash1[key][:total] += company.count
    end

    @fifth = hash1.each_with_index do |v, i|
      key = v[0]
      hash2[key] = 0 if hash2[key].blank?

      hash2[key] += (v[1][:promoters] * 100 / v[1][:total]).to_f -
                    (v[1][:detractors] * 100 / v[1][:total]).to_f
    end
  end

  # def high_load_db
  #   10000.times do
  #     fifth_task
  #   end
  # end

  def high_load_db_with_error
    10000.times do
      fifth_task
    end

    begin
      #qwerty
    rescue => e
      puts e
    end
  end
end
