Recaptcha.configure do |config|
  if Rails.env.production?
    config.public_key  = '6Ld5K8wSAAAAAPhuDJi6OaoxUB9cZrwNItFWpYYu'
    config.private_key = '6Ld5K8wSAAAAALEZYW95gHI0ZHkB-pS_wAofn2qA'
  elsif Rails.env.staging?
    config.public_key  = '6Lc6E9QSAAAAAP3xGSDCpys_4ezfPG6I-Si7youd'
    config.private_key = '6Lc6E9QSAAAAACnjppBJf_GCQuzpwKR40UExU7F5'    
  elsif Rails.env.development? 
    config.public_key  = '6LckaMwSAAAAALEaYZxMRISiig5C5JrWIDJpBTcM'
    config.private_key = '6LckaMwSAAAAAIbNYIERmBFsFW6wjO2KZ-Q_nOmP'
  end
end