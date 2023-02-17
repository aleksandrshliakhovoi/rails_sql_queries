class FillSeedDb < ActiveRecord::Migration[7.0]
  def change
    Organization.destroy_all

    orgs = %w[Douglas Fitx BMW REWE].map do |org_name|
      Organization.create(name: org_name)
    end
    
    orgs.each do |org|
      1.upto(10).each do |i|
        name = "Branch #{org.name} #{i.to_s.rjust(2, '0')}"
        org.branches.create(name: name)
      end
    end
    
    from = Time.new(2010, 1, 1)
    to = Time.new(2018, 5, 1)
    
    100.times do
      quality        = 1.upto(5).to_a.sample
      age_group      = %w[01-19 20-29 30-39 40-49 50-59 60+ ]
      nps            = 0.upto(10).to_a.sample
      status         = %w[valid canceled].sample
      org            = orgs.sample
      branch         = org.branches.sample
      experienced_at = Time.at(from + rand * (to.to_f - from.to_f))
    
      Feedback.create(
        quality: quality,
        age_group: age_group,
        nps: nps,
        status: status,
        branch: branch,
        experienced_at: experienced_at
      )
    end
  end
end
