classdef test1 < matlab.uitest.TestCase
    properties
        UI1
        UI2
        UI3
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)

            Master = MasterServer1;
            testCase.UI1 = playerUIfntest;
            testCase.UI2 = playerUIfntest;
            testCase.UI3 = playerUIfntest;

            testCase.UI1.MasterProcessor=Master;
            testCase.UI2.MasterProcessor=Master;
            testCase.UI3.MasterProcessor=Master;

            Master.Player1UI = testCase.UI1;
            Master.Player2UI = testCase.UI2;
            Master.Player3UI = testCase.UI3;
            Master.GameState = false;    % the game is off at intial
            Master.everyone_ready=0;
      
            testCase.addTeardown(@delete,testCase.UI1);
            testCase.addTeardown(@delete,testCase.UI2);
            testCase.addTeardown(@delete,testCase.UI3);
        end
    end
    
    methods (Test)
        function test(testCase)
            % test 1 lord win
          %  testCase.type(testCase.App1.HScodeEditField,'A000');
            testCase.press(testCase.UI1.startButton);
            pause(0.8);
            testCase.press(testCase.UI2.startButton);
            pause(0.3);
            testCase.press(testCase.UI3.startButton);
            pause(0.3);
            
            testCase.verifyEqual(testCase.UI1.messageLabel.Text,{'welcome to pocker game !'} );
            testCase.verifyEqual(testCase.UI2.messageLabel.Text,{'welcome to pocker game !'} );
            testCase.verifyEqual(testCase.UI3.messageLabel.Text,{'welcome to pocker game !'} );
            
            testCase.press(testCase.UI2.LordButton);
            pause(1.2);
            testCase.press(testCase.UI3.LordButton);
            pause(1.2);
            testCase.press(testCase.UI1.LordButton);
            pause(1.2);
            testCase.press(testCase.UI2.LordButton);  
            pause(1.2);
            
            %round 1
            testCase.press(testCase.UI2.card2Button);  
            pause(0.3);
            testCase.press(testCase.UI2.card3Button);  
            pause(0.3);
            testCase.press(testCase.UI2.card4Button);  
            pause(0.3);
            testCase.press(testCase.UI2.card1Button);  
            pause(0.3); 
            testCase.press(testCase.UI2.playButton);  
            pause(1.5);
            
            testCase.press(testCase.UI3.card3Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card6Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card7Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card8Button);  
            pause(0.3);
            testCase.press(testCase.UI3.playButton);  
            pause(1.5);
            
            testCase.press(testCase.UI1.passButton);  
            pause(1);
            testCase.press(testCase.UI2.passButton); 
            pause(1);
            
            %round 2
            testCase.press(testCase.UI3.card3Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card4Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card6Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card7Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card8Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card9Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card10Button);
            pause(0.3);
            testCase.press(testCase.UI3.card11Button);
            pause(0.3);
            testCase.press(testCase.UI3.playButton);
            pause(1);
           
            
            testCase.press(testCase.UI1.card12Button);
            pause(1);
            testCase.press(testCase.UI1.card13Button);
            pause(1);
            testCase.press(testCase.UI1.card14Button);
            pause(1);
            testCase.press(testCase.UI1.card15Button);
            pause(1);
            testCase.press(testCase.UI1.card16Button);
            pause(1);
            testCase.press(testCase.UI1.card17Button);
            pause(1);
            testCase.press(testCase.UI1.card10Button);
            pause(1);
            testCase.press(testCase.UI1.card11Button);
            pause(0.3);
            testCase.press(testCase.UI1.card9Button);
            pause(0.3);
            testCase.press(testCase.UI1.playButton);
            testCase.verifyEqual(testCase.UI1.messageLabel.Text,"illegal cards!!!!!  choose again " );
            pause(1);
            
            testCase.press(testCase.UI1.card9Button);
            pause(1);
            testCase.press(testCase.UI1.playButton);
            
            testCase.press(testCase.UI2.passButton);
            pause(1);
            testCase.press(testCase.UI3.passButton);
            testCase.verifyEqual(testCase.UI1.messageLabel.Text,"they all pass " );
            
            pause(1);
            
            %round 3
            testCase.press(testCase.UI1.card5Button);
            pause(0.3);
            testCase.press(testCase.UI1.card6Button);
            pause(0.3);
            testCase.press(testCase.UI1.card7Button);
            pause(0.3);
            testCase.press(testCase.UI1.card8Button);
            pause(0.3);
            testCase.press(testCase.UI1.card9Button);
            pause(0.3);
            testCase.press(testCase.UI1.playButton);
            pause(1);
            
            testCase.press(testCase.UI2.card8Button);
            pause(0.3);
            testCase.press(testCase.UI2.card9Button);
            pause(0.3);
            testCase.press(testCase.UI2.card10Button);
            pause(0.3);
            testCase.press(testCase.UI2.card11Button);
            pause(0.3);
            testCase.press(testCase.UI2.card12Button);
            pause(0.3);
            testCase.press(testCase.UI2.card13Button);
            pause(0.3);
            testCase.press(testCase.UI2.playButton);
            pause(1);
            
            testCase.press(testCase.UI2.card13Button);
            pause(1);
            testCase.press(testCase.UI2.playButton);
            pause(1);
            
            testCase.press(testCase.UI3.passButton);
            pause(1);
            testCase.press(testCase.UI1.passButton);
            pause(1);
            
            %round 4
            testCase.press(testCase.UI2.card1Button);
            pause(0.3);
            testCase.press(testCase.UI2.card2Button);
            pause(0.3);
            testCase.press(testCase.UI2.card3Button);
            pause(0.3);
            testCase.press(testCase.UI2.card4Button);
            pause(0.3);
            testCase.press(testCase.UI2.card5Button);
            pause(0.3);
            testCase.press(testCase.UI2.card6Button);
            pause(0.3);
            testCase.press(testCase.UI2.playButton);
            pause(1);
            
            testCase.press(testCase.UI3.passButton);
            pause(0.3);
            testCase.press(testCase.UI1.passButton);
            pause(0.3);
            
            %round 5
            testCase.press(testCase.UI2.card1Button);
            pause(0.3);
            testCase.press(testCase.UI2.playButton);
            pause(1);
            
            testCase.press(testCase.UI3.card4Button);
            pause(1);
            testCase.press(testCase.UI3.playButton);
            pause(1);
            
            testCase.press(testCase.UI1.passButton);
            pause(1);
            
            testCase.press(testCase.UI2.passButton);
            pause(1);
            
            %round 6
            testCase.press(testCase.UI3.card1Button);
            pause(0.3);
            testCase.press(testCase.UI3.card2Button);
            pause(0.3);
            testCase.press(testCase.UI3.playButton);
            pause(0.3);
            testCase.press(testCase.UI1.passButton);
            pause(0.3);
            testCase.press(testCase.UI2.card1Button);
            pause(0.3);
            testCase.press(testCase.UI2.card2Button);
            pause(1);
            testCase.press(testCase.UI2.playButton);
            pause(1);
            testCase.press(testCase.UI3.passButton);
            pause(0.3);
            testCase.press(testCase.UI1.passButton);
            pause(0.3);
            %round7
            testCase.press(testCase.UI2.card1Button);
            pause(0.3);
            testCase.press(testCase.UI2.card2Button);
            pause(0.3);
            testCase.press(testCase.UI2.playButton);
            pause(1);
            
            testCase.verifyEqual(testCase.UI2.messageLabel.Text,'game over lord is the winner' );
            pause(3);
            
        end
        

    end
    
end