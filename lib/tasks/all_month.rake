namespace :usgs do
  desc 'Get eathquake data from past 30 days'

  task all_month: :environment do
    require_relative '../usgs_client'
    usgs_client = UsgsClient.new
    puts '[INFO] requesting features from USGS API...'
    extracted_features = usgs_client.extract_data
    puts "[INFO] Got #{extracted_features.size} features"
    puts '[INFO] persisting...'

    begin
      Feature.insert_all(extracted_features, unique_by: :record_id)
      puts '[INFO] Done!'
    rescue ActiveRecord::StatementInvalid => e
      puts "[WARN] error: #{e}"
    end
  end
end
