Fabricator(:site) do
  short_path "abcdef"
  destination { Faker::Internet.domain_name }
end
