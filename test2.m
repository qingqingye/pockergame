classdef test2 < matlab.uitest.TestCase
    properties
        UI1
        UI2
        UI3
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)

            Master = MasterServer2;
            testCase.UI1 = playerUItest;
            testCase.UI2 = playerUItest;
            testCase.UI3 = playerUItest;
        
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
            testCase.press(testCase.UI1.startButton);
            pause(0.3);
            testCase.press(testCase.UI2.startButton);
            pause(0.3);
            testCase.press(testCase.UI3.startButton);
            pause(0.3);

            testCase.verifyEqual(testCase.UI1.MessageTextArea.Value, {'welcome to pocker game !'} );
            testCase.verifyEqual(testCase.UI2.MessageTextArea.Value, {'welcome to pocker game !'} );
            testCase.verifyEqual(testCase.UI3.MessageTextArea.Value, {'welcome to pocker game !'}  );
            
            testCase.press(testCase.UI2.giveupButton);
            pause(1);
            testCase.press(testCase.UI3.giveupButton);
            pause(1);
            testCase.press(testCase.UI1.LordButton);
            pause(1);
            
            %roud1
            testCase.press(testCase.UI1.card1Button);  
            pause(0.3);
            testCase.press(testCase.UI1.card2Button);  
            pause(0.3);
            testCase.press(testCase.UI1.playButton);  
            pause(0.3);
            
            testCase.press(testCase.UI2.passButton);  
            pause(1);
            testCase.press(testCase.UI3.card1Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card2Button);  
            pause(0.3);
            testCase.press(testCase.UI3.playButton);  
            pause(0.5);
    
            testCase.press(testCase.UI1.passButton);  
            pause(0.5);
            testCase.press(testCase.UI2.passButton);  
            pause(0.5);
 
            %round 2
            testCase.press(testCase.UI3.card1Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card2Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card3Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card4Button);  
            pause(0.3);  
            testCase.press(testCase.UI3.card5Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card7Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card8Button);  
            pause(0.3);          
            testCase.press(testCase.UI3.playButton);  
            pause(1);
            
            testCase.press(testCase.UI3.card7Button);  
            pause(0.3);
            testCase.press(testCase.UI3.card8Button);  
            pause(0.3); 
            testCase.press(testCase.UI3.card6Button);  
            pause(0.3);
            testCase.press(testCase.UI3.playButton);  
            pause(1); 
            
            testCase.press(testCase.UI1.passButton);
            testCase.press(testCase.UI2.card3Button);
            testCase.press(testCase.UI2.card4Button);
            testCase.press(testCase.UI2.card5Button);
            testCase.press(testCase.UI2.card6Button);
            testCase.press(testCase.UI2.playButton);
            pause(0.5);
            
            testCase.press(testCase.UI3.passButton);
            pause(0.5);
            testCase.press(testCase.UI1.passButton);
            pause(0.5);
            
            %round 3
            testCase.press(testCase.UI2.card3Button);
            testCase.press(testCase.UI2.card4Button);
            testCase.press(testCase.UI2.card5Button);
            testCase.press(testCase.UI2.card6Button);
            testCase.press(testCase.UI2.card7Button);
            testCase.press(testCase.UI2.card8Button);
            pause(0.5);
            testCase.press(testCase.UI2.playButton);
            pause(0.5);
            
            testCase.press(testCase.UI3.card1Button);
            testCase.press(testCase.UI3.card2Button);
            testCase.press(testCase.UI3.card3Button);
            testCase.press(testCase.UI3.card4Button);
            testCase.press(testCase.UI3.card5Button);
            testCase.press(testCase.UI3.card6Button);
            pause(0.5);
            testCase.press(testCase.UI3.playButton);
            
            testCase.press(testCase.UI1.card9Button);
            testCase.press(testCase.UI1.card10Button);
            testCase.press(testCase.UI1.card11Button);
            testCase.press(testCase.UI1.card12Button);
            testCase.press(testCase.UI1.playButton);
            
            testCase.press(testCase.UI2.passButton);
            pause(0.5);
            testCase.press(testCase.UI3.passButton);
            pause(0.5);
            
            %round 4
            testCase.press(testCase.UI1.card1Button);
            testCase.press(testCase.UI1.card2Button);
            pause(0.5);
            testCase.press(testCase.UI1.playButton);
            testCase.press(testCase.UI2.passButton);
            testCase.press(testCase.UI3.card2Button);
            testCase.press(testCase.UI3.card3Button);
            testCase.press(testCase.UI3.playButton);
        
            
            testCase.press(testCase.UI1.card11Button);
            testCase.press(testCase.UI1.card12Button);
            pause(0.5);
            testCase.press(testCase.UI1.playButton);
            pause(0.5);
            
            testCase.press(testCase.UI2.passButton);
            pause(0.5);
            
            testCase.press(testCase.UI3.passButton);
            pause(1);
            
            %round 5
            testCase.press(testCase.UI1.card2Button);
            testCase.press(testCase.UI1.playButton);   
            testCase.press(testCase.UI2.passButton);  
            testCase.press(testCase.UI3.card1Button);
            testCase.press(testCase.UI3.playButton);
            pause(3);
%             testCase.verifyEqual(testCase.UI1.MessageTextArea.Value ,{'game over farmer is the winner'} );
%             testCase.verifyEqual(testCase.UI2.MessageTextArea.Value ,{'game over farmer is the winner'} );
%             testCase.verifyEqual(testCase.UI3.MessageTextArea.Value ,{'game over farmer is the winner'});
           
        end      
    end
    
end
