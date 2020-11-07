Given "the following movies exist:" do |table|
    table.hashes.each do |row|
        Movie.create!(row)
    end
end

When "I check all ratings" do
    Movie.all_ratings.each do |rating|
        check("ratings[#{rating}]")
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

Then "I should see all of the movies" do
    titles = Movie.all.map { |movie| movie.title }

    if page.respond_to? :should
        titles.each { |title| page.should have_content(title) }
    else
        titles.each { |title| assert page.has_content?(title) }
    end
end

Then /^I should see "([^"]*)" before "([^"]*)"$/ do |title1, title2|
    if page.respond_to? :should
        page.should have_content(/#{title1}(.*)#{title2}/m)
    else
        assert page.has_content?(/#{title1}(.*)#{title2}/m)
    end
end
