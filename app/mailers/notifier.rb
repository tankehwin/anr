class Notifier < ActionMailer::Base
  default :from => "Morpheous", :date => Time.now
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.password_reset_instructions.subject
  #
  def password_reset_instructions user
    host = "anr.sentulasia.com"
    @user = user
    @password_reset_url = "http://#{host}/password_resets/" + @user.perishable_token + "/edit"
    mail(:to => user.email, :subject => "[A:NR Scheduler] Password Reset Instructions") do |format|
      format.text { render :text => "A request to reset your password has been made.\r\nIf you did not make this request, simply ignore this email.\r\nIf you did make this request just click the link below:\r\n\r\n" + @password_reset_url + "\r\n\r\nIf the above URL does not work try copying and pasting it into your browser. If you continue to have problem please feel free to contact us.\r\n\r\nLove,\r\nA:NR Scheduler Team\r\n\r\n--------------------------------------------------------------\r\n\r\nThis message was intended for " + @user.email + "\r\nIf you are not the above recipient, kindly ignore this email and please accept our apologies.\r\n\r\nTableFour.Us is all about good food and great company!" }
      format.html { render :text => "<style>a:link,a:visited{color:#931100;text-decoration:none;}a:hover,a:active{color:#931100;text-decoration:underline;}</style>
        <div style='text-align:center;background-color:#a63c2e;margin:0px;padding:0px;width:100%;'><div style='height:10px;'></div>
        
        <div style='width:600px;padding:0px;margin-bottom:10px;margin-left:auto;margin-right:auto;'>
        <img src='http://app.tablefour.us/images/tableFour.UsHeader.png'></div>
        
        <div style='background-color:#fff;-moz-border-radius:15px;-webkit-border-radius:15px;border-radius:15px;width:520px;padding:20px 40px 20px 40px;margin-bottom:10px;margin-left:auto;margin-right:auto;'>
        <p style='text-align:left;font-size:12pt;color:#505050'>A request to reset your password has been made.<br />
        If you did not make this request, simply ignore this email.<br />
        If you did make this request just click <a href='" + @password_reset_url + "'>this link</a>.</p>
        
        <img style='float:right;width:150px;' src='http://app.tablefour.us/images/pot.png'>
        <p style='text-align:left;font-size:12pt;color:#505050'>If you have problem resetting your password please feel free to contact us.</p>
        
        <p style='text-align:left;font-size:12pt;color:#505050'>Till then, have a great meal!</p>
        
        <p style='text-align:left;font-size:12pt;color:#505050'>Love,<br />
        Maitre'd, <a style='color:#505050;text-decoration:none;'>TableFour.Us</a></p></div>
        
        <div style='width:520px;margin-left:auto;margin-right:auto;'>
        <p style='text-align:left;color:#fff'>This message was intended for <a style='color:#fff;text-decoration:none;'>" + @user.email + "</a><br />
        If you are not the above recipient, kindly ignore this email and please accept our apologies.</p>
        
        <p style='text-align:left;color:#fff'><a style='color:#fff;text-decoration:none;'>TableFour.Us</a> is all about good food and great company!</p>
        <div style='height:5px;'></div></div></div>"
      }
    end
  end
end
