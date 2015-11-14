% this file affectiv.m shows how to call expressiv functions in matlab. 
% The result is displayed on Command Window ! Ctrl-C to terminate.
%function [affective,alpha]=affectiv_rec(rectime)
%load('open_close_10s_60t_notnormalised');
structs.InputSensorDescriptor_struct.members=struct('channelId', 'EE_InputChannels_enum', 'fExists', 'int32', 'pszLabel', 'cstring', 'xLoc', 'double', 'yLoc', 'double', 'zLoc', 'double');
enuminfo.EE_DataChannels_enum=struct('ED_COUNTER',0,'ED_INTERPOLATED',1,'ED_RAW_CQ',2,'ED_AF3',3,'ED_F7',4,'ED_F3',5,'ED_FC5',6,'ED_T7',7,'ED_P7',8,'ED_O1',9,'ED_O2',10,'ED_P8',11,'ED_T8',12,'ED_FC6',13,'ED_F4',14,'ED_F8',15,'ED_AF4',16,'ED_GYROX',17,'ED_GYROY',18,'ED_TIMESTAMP',19,'ED_ES_TIMESTAMP',20,'ED_FUNC_ID',21,'ED_FUNC_VALUE',22,'ED_MARKER',23,'ED_SYNC_SIGNAL',24);
enuminfo.EE_CognitivTrainingControl_enum=struct('COG_NONE',0,'COG_START',1,'COG_ACCEPT',2,'COG_REJECT',3,'COG_ERASE',4,'COG_RESET',5);
enuminfo.EE_ExpressivAlgo_enum=struct('EXP_NEUTRAL',1,'EXP_BLINK',2,'EXP_WINK_LEFT',4,'EXP_WINK_RIGHT',8,'EXP_HORIEYE',16,'EXP_EYEBROW',32,'EXP_FURROW',64,'EXP_SMILE',128,'EXP_CLENCH',256,'EXP_LAUGH',512,'EXP_SMIRK_LEFT',1024,'EXP_SMIRK_RIGHT',2048);
enuminfo.EE_ExpressivTrainingControl_enum=struct('EXP_NONE',0,'EXP_START',1,'EXP_ACCEPT',2,'EXP_REJECT',3,'EXP_ERASE',4,'EXP_RESET',5);
enuminfo.EE_ExpressivThreshold_enum=struct('EXP_SENSITIVITY',0);
enuminfo.EE_CognitivEvent_enum=struct('EE_CognitivNoEvent',0,'EE_CognitivTrainingStarted',1,'EE_CognitivTrainingSucceeded',2,'EE_CognitivTrainingFailed',3,'EE_CognitivTrainingCompleted',4,'EE_CognitivTrainingDataErased',5,'EE_CognitivTrainingRejected',6,'EE_CognitivTrainingReset',7,'EE_CognitivAutoSamplingNeutralCompleted',8,'EE_CognitivSignatureUpdated',9);
enuminfo.EE_EmotivSuite_enum=struct('EE_EXPRESSIV',0,'EE_AFFECTIV',1,'EE_COGNITIV',2);
enuminfo.EE_ExpressivEvent_enum=struct('EE_ExpressivNoEvent',0,'EE_ExpressivTrainingStarted',1,'EE_ExpressivTrainingSucceeded',2,'EE_ExpressivTrainingFailed',3,'EE_ExpressivTrainingCompleted',4,'EE_ExpressivTrainingDataErased',5,'EE_ExpressivTrainingRejected',6,'EE_ExpressivTrainingReset',7);
enuminfo.EE_CognitivAction_enum=struct('COG_NEUTRAL',1,'COG_PUSH',2,'COG_PULL',4,'COG_LIFT',8,'COG_DROP',16,'COG_LEFT',32,'COG_RIGHT',64,'COG_ROTATE_LEFT',128,'COG_ROTATE_RIGHT',256,'COG_ROTATE_CLOCKWISE',512,'COG_ROTATE_COUNTER_CLOCKWISE',1024,'COG_ROTATE_FORWARDS',2048,'COG_ROTATE_REVERSE',4096,'COG_DISAPPEAR',8192);
enuminfo.EE_InputChannels_enum=struct('EE_CHAN_CMS',0,'EE_CHAN_DRL',1,'EE_CHAN_FP1',2,'EE_CHAN_AF3',3,'EE_CHAN_F7',4,'EE_CHAN_F3',5,'EE_CHAN_FC5',6,'EE_CHAN_T7',7,'EE_CHAN_P7',8,'EE_CHAN_O1',9,'EE_CHAN_O2',10,'EE_CHAN_P8',11,'EE_CHAN_T8',12,'EE_CHAN_FC6',13,'EE_CHAN_F4',14,'EE_CHAN_F8',15,'EE_CHAN_AF4',16,'EE_CHAN_FP2',17);
enuminfo.EE_ExpressivSignature_enum=struct('EXP_SIG_UNIVERSAL',0,'EXP_SIG_TRAINED',1);
enuminfo.EE_Event_enum=struct('EE_UnknownEvent',0,'EE_EmulatorError',1,'EE_ReservedEvent',2,'EE_UserAdded',16,'EE_UserRemoved',32,'EE_EmoStateUpdated',64,'EE_ProfileEvent',128,'EE_CognitivEvent',256,'EE_ExpressivEvent',512,'EE_InternalStateChanged',1024,'EE_AllEvent',2032);
enuminfo.EE_AffectivAlgo_enum=struct('AFF_EXCITEMENT',1,'AFF_MEDITATION',2,'AFF_FRUSTRATION',4,'AFF_ENGAGEMENT_BOREDOM',8);
DataChannels = enuminfo.EE_DataChannels_enum;
DataChannelsNames = {'ED_COUNTER','ED_INTERPOLATED','ED_RAW_CQ','ED_AF3','ED_F7','ED_F3','ED_FC5','ED_T7','ED_P7','ED_O1','ED_O2','ED_P8','ED_T8','ED_FC6','ED_F4','ED_F8','ED_AF4','ED_GYROX','ED_GYROY','ED_TIMESTAMP','ED_ES_TIMESTAMP','ED_FUNC_ID','ED_FUNC_VALUE','ED_MARKER','ED_SYNC_SIGNAL'};

% Check to see if library was already loaded
if ~libisloaded('edk')    
    [nf, w] = loadlibrary('edk','edk', 'addheader', 'EmoStateDLL', 'addheader', 'edkErrorCode');
	disp(['EDK library loaded']);    
else
    disp(['EDK library already loaded']);
    end

%libfunctionsview('edk');
global s1
%fclose(s1);
%delete(s1);
default = int8(['Emotiv Systems-5' 0]);
AllOK = calllib('edk','EE_EngineConnect', 'Emotiv Systems-5'); % success means this value is 0
eEvent = calllib('edk','EE_EmoEngineEventCreate');
eState = calllib('edk','EE_EmoStateCreate');
med=0;
excs=0;
eng=0;
frus=0;
count = 0;
tic
t=clock;
oldstate=0;
mystate=0;

%s1 = serial('COM15','BaudRate',9600);
%fopen(s1);
 while ((AllOK == 0))
    state = calllib('edk','EE_EngineGetNextEvent',eEvent); % state = 0 if everything's OK
    eventType = calllib('edk','EE_EmoEngineEventGetType',eEvent);
    %disp(eventType);
    userID=libpointer('uint32Ptr',0);    
    calllib('edk','EE_EmoEngineEventGetUserId',eEvent, userID);

    if strcmp(eventType,'EE_EmoStateUpdated') == true        
        
        emoState = calllib('edk','EE_EmoEngineEventGetEmoState',eEvent,eState);
        if emoState == 0
            med = calllib('edk','ES_AffectivGetMeditationScore',eState);
            excs = calllib('edk','ES_AffectivGetExcitementShortTermScore',eState);
            eng = calllib('edk','ES_AffectivGetEngagementBoredomScore',eState);
            %frus = calllib('edk','ES_AffectivGetFrustrationScore',eState);
            %val = calllib('edk','ES_AffectivGetValenceScore',eState);
            %excl = calllib('edk','ES_AffectivGetExcitementLongTermScore',eState);
            %ExpressIsActiv = calllib('edk','ES_ExpressivIsBlink',eState)
            
            if all([med,excs,eng])
                  count = count +1;
                  affective(count,1:3)=[med,excs,eng];
                  norml=diag(Normal([med,excs,eng]',Mu, R, 2));
                  norml=norml/max(max(norml));
                  if count==1
                    Alpha(count,:) = norml*p0;  
                  else
                      Alpha(count,:) = (norml*P*Alpha(count-1,:)')';
                      Alpha(count,:) = Alpha(count,:)/mean(Alpha(count,:));
                  end
                  
                  [value mystate]= max(Alpha(count,:))
                   if mystate ~= oldstate
                       %zigbee_pi(mystate);
                   end
                   oldstate=mystate;
            end
             pause(0.02);
        end    	
    end   

 end
toc
calllib('edk','EE_EngineDisconnect')
calllib('edk','EE_EmoStateFree',eState);
calllib('edk','EE_EmoEngineEventFree',eEvent);


