classdef MasterServer2 < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    % a1 a2 a3 means actor 1:lord 0:farmer 
    %p1 p2 p3 means player's cards in hands
    properties
        Player1UI
        Player2UI
        Player3UI
        cards1
        cards2
        cards3
        cardsL
        roblist
        robtimes
        lordCC  %lord card choose
        a1
        a2
        a3
        GameState
        deskCards
        everyone_ready
        currentPlayer
        currentPlayerNum
        winner
        passtimes
    end
    
    methods         
        function [p1, p2, p3,lordCards] = sendoutCards(self)
%             allCards = randperm(54);
%             p1 = allCards(1:17);
%             p2 = allCards(18:34);
%             p3 = allCards(35:51);
%             lordCards = allCards(52:54);
            %test1
%             p1 = [1,2,3,5,6,9,13,17,21,29,30,41,42,43,45,46,47];
%             p2 = [4,10,11,12,14,15,18,19,22,23,25,31,33,37,44,48,49];
%             p3 = [7,8,16,20,24,26,27,28,32,34,35,36,38,39,40,50,51];
%             lordCards = [52,53,54];
%             
            
            %test2
            p1 = [1,2,5,6,17,21,29,33,37,38,41,42,43,45,46,47,54];
            p2 = [3,4,9,10,11,12,18,19,22,23,25,26,30,34,39,48,49];
            p3 = [7,8,13,14,15,16,20,24,27,28,31,32,35,36,40,50,51];
            lordCards = [44,52,53];
            
            fprintf("sending cards\n")
            self.Player1UI.showLC(lordCards,true);
            self.Player2UI.showLC(lordCards,true);
            self.Player3UI.showLC(lordCards,true);
            self.Player1UI.showCards(sort(p1), 17, 17);
            self.Player2UI.showCards(sort(p2) ,17, 17);
            self.Player3UI.showCards(sort(p3) ,17, 17);
        end
      
  
%         function newGame(self)       
%             while ~everyone_ready
%                 everyone_ready = self.Player1UI.start &&  self.Player2UI.start && self.Player3UI.start;
%                 pause(0.5);
%             end

        function nextRob(self,currentDecider,decision)
            if decision==0       
                self.roblist(self.roblist==currentDecider)=[];%delete giveup player from list
            else
                self.robtimes(currentDecider)=self.robtimes(currentDecider)+1;
            end    
            
            if isempty(self.roblist)           %everyone giveup who get lordcards must be lord
                self.reallyStart(self.lordCC); 
             
            elseif length(self.roblist(:))==1 & self.robtimes(self.roblist(1))~=0    % only one rob lord 
                self.reallyStart(self.roblist(1));
                
            elseif self.robtimes(currentDecider)==2
                self.reallyStart(currentDecider);
            else
                nextDecider=currentDecider +1;
                if nextDecider==4
                    nextDecider=1;
                end
                
                while ~ismember(nextDecider,self.roblist)
                    nextDecider=nextDecider+1;
                    if nextDecider==4
                        nextDecider=1;
                    end
                end
                 
                switch nextDecider
                     case 1
                         self.Player1UI.showRob(nextDecider);
                     case 2
                         self.Player2UI.showRob(nextDecider);
                     case 3
                         self.Player3UI.showRob(nextDecider);         
                 end           
                
            end 
                       
        end 
        
        
        function startGame(self)
            self.GameState = true;
            self.Player1UI.head([100,101,102]);
            self.Player2UI.head([101,102,100]);
            self.Player3UI.head([102,100,101]);         
            [ p1, p2, p3,lordCards ] = self.sendoutCards();
            self.cards1=p1;
            self.cards2=p2;
            self.cards3=p3;
            self.cardsL=lordCards;
            %%    start rob lord  
          %   lastDecide = false;
          %  currentDecider = randi(3);
            currentDecider=2;
            self.lordCC=currentDecider; 
            self. roblist=[1,2,3];
            self.robtimes=[0,0,0];
             switch currentDecider 
                 case 1
                     self.Player1UI.showRob(currentDecider);
                 case 2
                     self.Player2UI.showRob(currentDecider);
                 case 3
                     self.Player3UI.showRob(currentDecider);         
             end                  
        end
       
      %%  
        function reallyStart(self,lord)
             self.a1=0;
             self.a2=0;
             self.a3=0;
             self.passtimes=0;
             p1=self.cards1;
             p2=self.cards2;
             p3=self.cards3;
             lordCards=self.cardsL;
             if lord==1
                 self.a1=1;
                 p1 = [self.cards1, lordCards];
                 self.currentPlayer = self.Player1UI;
                 self.currentPlayerNum=1;
             elseif lord==2 
                 self.a2=1;
                 p2 = [self.cards2, lordCards];
                 self.currentPlayer = self.Player2UI;
                 self.currentPlayerNum=2;  
             elseif lord==3
                 self.a3=1;
                 p3 = [self.cards3, lordCards];
                 self.currentPlayer = self.Player3UI;
                 self.currentPlayerNum=3;
             end
             self.cards1=p1;
             self.cards2=p2;
             self.cards3=p3;
            fprintf(" lord has selected");
            self.actorUpdate(lordCards, sort(p1), sort(p2), sort(p3), self.a1,self.a2, self.a3);
            noskip=true;
            self.currentPlayer.showCardsButton(noskip);   %the first one can not pass
        end 
        
           %%  time to earn money
           
        function loop(self,pass)   
            if pass
                self.passtimes=self.passtimes+1;
            else
                self.passtimes=0;     
            end
            p1=self.cards1;
            p2=self.cards2;
            p3=self.cards3;
            nowSplit =self.currentPlayer.playCards  %  get his decision        
            if ~isempty(nowSplit)   
               self.deskCards=nowSplit;        
            end   %if choose pass don not change temp
            switch self.currentPlayerNum
                case 1
                    [p1]=self.deleteCard(p1,nowSplit);
                    self.cards1=p1;
                case 2
                     [p2]=self.deleteCard(p2,nowSplit);
                      self.cards2=p2;
                case 3
                     [p3]=self.deleteCard(p3,nowSplit);
                      self.cards3=p3;
            end
            self. actorUpdate(self.cardsL, sort(p1),sort(p2),sort(p3),self.a1,self.a2,self.a3) ;
            self.deskUpdate(self.deskCards); 

            if ~isempty(p1) && ~isempty(p2) && ~isempty(p3)

                nextPlayerNum=self.currentPlayerNum +1;
                if nextPlayerNum==4
                    nextPlayerNum=1;
                end     
               
                switch nextPlayerNum
                    case 1
                        self.currentPlayer = self.Player1UI;
                        self.currentPlayerNum = 1;
                    case 2
                       self.currentPlayer = self.Player2UI;
                       self.currentPlayerNum = 2; 
                       
                    case 3
                        self.currentPlayer = self.Player3UI;
                        self.currentPlayerNum = 3; 
                end  
                if self.passtimes==2
                     self.currentPlayer.twopass();
                end
                
                self.getNowSplit();        %enable nextplayers' cards button
                
            else
                fprintf("gameover")
                self.winner = self.currentPlayerNum;
                self.gameover();
                
            end
            
        end
        
        function gameover(self)
             switch self.winner
                 case 1 
                     winnerACT = self.a1;
                 case 2
                     winnerACT = self.a2;
                 case 3 
                     winnerACT= self.a3;    
             end    
             
             if winnerACT==1
                 winnerSTR='lord';
             else 
                 winnerSTR='farmer';
             end    
            
            self.Player1UI.gameover(winnerSTR);
            self.Player2UI.gameover(winnerSTR);
            self.Player3UI.gameover(winnerSTR);
                 
        end
        
        %%
     
      function  [newp]=deleteCard(self,p,nowsplit)
          if ~isempty(nowsplit)
              for i =1:length(nowsplit)
                  address= p==nowsplit(i);
                  p(address)=[];
              end   
          end   
          newp = p;
      end   
      
       %%  an important def to play the game
       function getNowSplit(self)  
           % self.currentPlayer.decided = false;
            %while ~self.currentPlayer.decided   %when decided=0 keep wait here
               % self.currentPlayer.showPlayButton(noskip);
                %pause(0.5);
            %end     
            noskip = false;
            self.currentPlayer.showCardsButton(noskip);   
       end
        
        %% update the cards on table
        function deskUpdate(self, nowSplit)
            self.Player1UI.showDesk(nowSplit,self.cards1);
            self.Player2UI.showDesk(nowSplit,self.cards2);
            self.Player3UI.showDesk(nowSplit,self.cards3);
        end
          
        % after decide actor run this 
        function actorUpdate(self,lordCards, p1,p2,p3, a1, a2, a3)
            self.Player1UI.showLC(lordCards,false);
            self.Player2UI.showLC(lordCards,false);
            self.Player3UI.showLC(lordCards,false);
            self.Player1UI.showCards( p1 ,length(p2), length(p3));
            self.Player2UI.showCards(p2, length(p3), length(p1));
            self.Player3UI.showCards(p3, length(p1), length(p2));
            self.Player1UI.updatePlayer( a2, a3, a1);
            self.Player2UI.updatePlayer( a3, a1, a2);
            self.Player3UI.updatePlayer( a1, a2, a3);
        
        end
        
    end
end

