Given "the following movies exist:" do |table|
    table.hashes.each do |row|
        Movie.create!(row)
    end
end

When /^I check the following ratings: (.*)$/ do |ratings|
    ratings.split(/,[ ]*/).each do |rating|
        check("ratings[#{rating}]")
    end
end

When /^I uncheck the following ratings: (.*)$/ do |ratings|
    ratings.split(/,[ ]*/).each do |rating|
        uncheck("ratings[#{rating}]")
    end
end