task generate_rbs_for_model: :environment do
  require 'rbs_rails'

  out_dir = Rails.root / 'sig'
  out_dir.mkdir unless out_dir.exist?

  Rails.application.eager_load!

  ActiveRecord::Base.descendants.each do |klass|
    next if klass.abstract_class?
    next if [ActionText::RichText, ActionMailbox::InboundEmail, ActiveStorage::Blob, ActiveStorage::Attachment].include? klass

    path = out_dir / "app/models/#{klass.name.underscore}.rbs"
    FileUtils.mkdir_p(path.dirname)

    sig = RbsRails::ActiveRecord.class_to_rbs(klass)
    path.write sig
  end
end
