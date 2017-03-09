function TurtleBotKeyboardTeleop(velPub,forwardVel,turnVel)
    
    % Modified MATLAB example code to publish only velocity messages and
    % nothing else. 

    persistent velMsg

    
    keyObj = ExampleHelperTurtleBotKeyInput();
    
    disp('Keyboard Control: ');
    disp('i=forward, k=backward, j=left, l=right');
    disp('q=quit');
    disp('Waiting for input: ');
    
    % Use ASCII key representations for reply, initialize here
    reply = 0;
 
    while reply~='q'
         
        forwardV = 0;   % Initialize linear and angular velocities
        turnV = 0;
        
        reply = getKeystroke(keyObj);
        switch reply
            case 'i'         % i
                forwardV = forwardVel;
            case 'k'     % k
                forwardV = -forwardVel;
            case 'j'     % j
                turnV = turnVel;
            case 'l'     % l
                turnV = -turnVel;
        end

        if isempty(velMsg)
            velMsg = rosmessage(velPub);
        end

        velMsg.Linear.X = forwardV;
        velMsg.Angular.Z = turnV;

        send(velPub,velMsg);

        pause(0.1);
    
    end
     
    closeFigure(keyObj);
    
end

