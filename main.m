clc
close all
clear all

Master = MasterServer;
UI1 = playerUIfn;
UI2 = playerUIfn;
UI3 = playerUIfn;

UI1.MasterProcessor=Master;
UI2.MasterProcessor=Master;
UI3.MasterProcessor=Master;
Master.Player1UI = UI1;
Master.Player2UI = UI2;
Master.Player3UI = UI3;
Master.GameState = false;    % the game is off at intial
Master.everyone_ready=0;
%Master.reallyStart(1);

