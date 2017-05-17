def upload_files files
  idx = []
  files = [files].flatten
  files.each do |f|
    uf = Admin::UploadedFile.create
    uf.image = Rails.root.join(f).open
    uf.save!
    idx << uf.id
  end
  idx
end