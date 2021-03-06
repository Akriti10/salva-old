require 'yaml'
class UserNotifier < ActionMailer::Base
  private
  def setup(options)
    smtp = YAML.load(File.read("#{RAILS_ROOT}/config/mail.yml"))
    domain = smtp['settings'][:domain].to_s
    @recipients = options[:recipients] || "noreply@#{domain}"
    @from = options[:from] || "noreply@#{domain}"
    @subject = "[SALVA] "
    @subject << options[:subject] unless options[:subject].nil?
    @body = options[:body] || {}
    @sent_on  = Time.now
  end

  public
  def new_notification(user,url,institution)
    setup({
            :recipients => user.email,
            :subject => 'Su cuenta ha sido creada, por favor activela...',
            :body => { :user => user, :url => url, :institution => institution}
    })
  end

  def activation(user,url,institution)
    setup({
            :recipients => user.email,
            :subject => 'Su cuenta ha sido activada',
            :body => { :user => user, :url => url, :institution => institution}
          })
  end

  def password_recovery(user,url,institution)
    setup({
            :recipients => user.email,
            :subject => 'Información para cambiar la contraseña de su cuenta',
            :body => { :user => user, :url => url, :institution => institution}
          })
  end
end
