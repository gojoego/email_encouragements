class EmailMailer < ApplicationMailer
    def send_email
        mail(   
                to: 'you@yourwebsite.com', 
                subject: 'keep your head up', 
                body: 'life is hard but you got this - keep coding and keep going!'
            )
    end
end
