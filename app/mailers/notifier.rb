class Notifier < ActionMailer::Base
  default :from => "Thomas A. Anderson", :date => Time.now
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.password_reset_instructions.subject
  #
  def congratulate user
    @user = user
    mail(:to => @user.email, :subject => "[A:NR Tournament Console] Congratulations!") do |format|
      format.text { render :text => "We would like to congratulate you on your achievement to to obtain first place in Sparta Tournament.\r\nWe hope to see more of your superb performance in the future tournament.\r\n\r\nLove,\r\Thomas A. Anderson,\r\nA:NR Tournament Console Team\r\n\r\n--------------------------------------------------------------\r\n\r\nThis message was intended for " + @user.email + "\r\nIf you are not the above recipient, kindly ignore this email and please accept our apologies." }
      format.html { render :text => "<style>a:link,a:visited{color:#931100;text-decoration:none;}a:hover,a:active{color:#931100;text-decoration:underline;}</style>
        <div style='text-align:center;background-color:#333;margin:0px;padding:10px;width:100%;'>
        
        <div style='width:600px;padding:0px;margin-bottom:10px;margin-left:auto;margin-right:auto;'>
        <img src='http://i.imgur.com/DTTDcYT.png'></div>
        
        <div style='background-color:#fff;-moz-border-radius:15px;-webkit-border-radius:15px;border-radius:15px;width:520px;padding:20px 40px 20px 40px;margin-bottom:10px;margin-left:auto;margin-right:auto;'>
        <p style='text-align:left;font-size:12pt;color:#505050'>We would like to congratulate you on your achievement to to obtain first place in Sparta Tournament.</p>
        
        <p style='text-align:left;font-size:12pt;color:#505050'>We hope to see more of your superb performance in the future tournament.</p>

        <img style='float:right;width:150px;' src='http://i.imgur.com/o5Masr9.png'>
        
        <p style='text-align:left;font-size:12pt;color:#505050'>Love,</p>
        
        <p style='text-align:left;font-size:12pt;color:#505050'>Thomas A. Anderson,<br />
        A:NR Tournament Console Team</p>

        <p><br /><br /></p>

        <p style='text-align:left;font-size:12pt;color:#505050'>This message was intended for <a style='color:#fff;text-decoration:none;'>" + @user.email + "</a>. If you are not the above recipient, kindly ignore this email and please accept our apologies.</p></div></div>"
      }
    end
  end
end
