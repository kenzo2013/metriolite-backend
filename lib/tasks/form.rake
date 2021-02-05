namespace :form do
  require 'yaml'

  # Run something like this rails form:create
  desc "Create form"
  task :create => :environment do
    begin
      start = Time.now
      data = YAML.load_file('db/data/form_data.yml')
      data.each do |el|
        form = Form.new(key: el["key"], name: el["name"], tags: el["tags"])
        if form.save!
          form.tags.each do |tag|
            form.inputs.create(date: tag["date"], note: tag["note"], value: tag["value"])
          end
        end
      end
      puts "Done in #{Time.now - start}s"
    rescue => e
      puts e
    end
  end

  # Run something like this rails "form:update[id=601bf6589014e50f0f67d245&name=Mon beau formulaire]"
  desc "Update form"
  task :update, [:params] => [:environment] do |t, args|
    begin
      start = Time.now
      params = Rack::Utils.parse_nested_query(args[:params])
      id = params.delete("id")
      form = Form.find(id)
      form.update(params)
      puts "Done in #{Time.now - start}s"
    rescue => e
      puts e
    end
  end

  # Run something like this rails 'form:delete[id=601bf6589014e50f0f67d245]'
  desc "Delete form"
  task :delete, [:params] => [:environment] do |t, args|
    begin
      start = Time.now
      params = Rack::Utils.parse_nested_query(args[:params])
      form = Form.find(params["id"])
      form.destroy
      puts "Done in #{Time.now - start}s"
    rescue => e
      puts e
    end
  end

end