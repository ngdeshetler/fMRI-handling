function secondlevel_make_fsf

SUBS={'502','503','505','507','508','509','510','511','512','513','514','516','517','518','519','520','521','522','523','524','525','526','527','528','529','530'};
%
%
%

tic
base_dir='/space/raid6/data/rissman/Natalie/MATCH_MISMATCH';
model='m3_smooth_sans_preEx';
%model='m4_smooth_sans';
out_name='m3_sans_preEx_all';
%out_name='m4_cue_all';
%

%% Chance below for different EVs
evs={'match_succ','foil_succ','mm_succ_pre','mm_succ_non'};
%evs={'cue_high_succ','cue_mod_succ','cue_low_succ','cue_no_succ','cue_high_incorrect','cue_mod_incorrect','cue_low_incorrect','cue_no_incorrect'};
evs_index=[3,4,5,6];
%evs_index=[1,2,3,4,5,6,7,8];
%% Contrast
%COPES=[.75 .25 -.25 -.75 0 0 0 0; .5 .5 -.5 -.5 0 0 0 0; 0 0 0 0 .75 .25 -.25 -.75; 0 0 0 0 .5 .5 -.5 -.5];
COPES=[1 0 0 -1;...
    -1 0 0 1;...
    0 1 0 -1;...
    0 -1 0 1;...
    0 0 1 -1;...
    0 0 -1 1;...
    1 0 -1 0;...
    -1 0 1 0;...
    0 1 -1 0;...
    0 -1 1 0;...
    1 -1 0 0;...
    -1 1 0 0;...
    .5 .5 -.5 -.5;...
    -.5 -.5 .5 .5;...
    1 -(1/3) -(1/3) -(1/3);...
    -1 (1/3) (1/3) (1/3);...
    .5 -.5 .5 -.5;...
    -.5 .5 -.5 .5;...
    .75 .25 -.25 -.75;...
    -.75 -.25 .25 .75];
%COPE_names={'succ_scalled','succ_bin','all_scalled','all_bin'};
COPE_names={'match_non','non_match','foil_non','non_foil','pre_non','non_pre','match_pre','pre_match','foil_pre','pre_foil','match_foil','foil_match',...
    'mf_mm','mm_mf','m_fmm','fmm_m','fam_novel','novel_fam','linear_match','linear_non'};
script_path=which('secondlevel_make_fsf.m');
script_dirct=fileparts(script_path);

all_variables=[];
cd(script_dirct)
load('../ALL_EVs_alt.mat')
cd('../..')
base_dir_alt=pwd;
cd(script_dirct)

for g=1:length(SUBS)
    
    sub_ID=sprintf('MM_%s',SUBS{g});
    fsf_ID='second_level_condensed';
    fsf=[base_dir_alt,'/',sub_ID,'/analysis/FEAT_FILES/gFEAT_',out_name,'.fsf'];
    fsf_clean=[base_dir_alt,'/',sub_ID,'/analysis/FEAT_FILES/gFEAT_',out_name,'_clean.fsf'];
    fsf_clean_out=[base_dir_alt,'/',sub_ID,'/analysis/FEAT_FILES'];
    
    
    command=sprintf('for i in ''%s.fsf''; do',fsf_ID);
    command=sprintf('%s\n sed -e ''s@OUTPUTT@''%s''@g'' \\\n',command,[base_dir,'/',sub_ID,'/analysis/',out_name]);
    contrast=[];
    copes=COPES;
    EVS=evs;
    to_remove=[];
    column=0;
    included=0;
    for m=1:length(evs)
        
        if all_variables.(sub_ID).(evs{m}).counts~=0
            column=column+1;
            for n=1:8
                if all_variables.(sub_ID).(evs{m}).block(n).count>0
                    included=included+1;
                    cope=sprintf('%s/%s/analysis/STAT/run%d_output_%s.feat/stats/cope%d.nii.gz',base_dir,sub_ID,n,model,evs_index(m));
                    command=sprintf('%s -e ''s@%s@''%s''@g'' \\\n ',command,sprintf('INPUT%03d',included),cope);
                    contrast(end+1,column)=1;
                    
                end
                
            end
        elseif all_variables.(sub_ID).(evs{m}).counts==0
            to_remove(1,end+1)=m;
        end
    end
    
    for i=1:size(contrast,1)
        for e=1:size(contrast,2)
             command=sprintf('%s -e ''s@%s@''%d''@g'' \\\n ',command,sprintf('EV%03d_INP%03d',e,i),contrast(i,e));
        end
    end

    if ~isempty(to_remove)
        copes(:,to_remove)=[];
        EVS(to_remove)=[];
        for j=1:size(copes,1)
            if sum(copes(j,:))<1 && sum(copes(j,:))>0
                to_fix=find(copes(j,:)<0);
                copes(j,to_fix)=-1/length(to_fix);
            elseif sum(copes(j,:))<1 && sum(copes(j,:))<0
                to_fix=find(copes(j,:)>0);
                copes(j,to_fix)=1/length(to_fix);
            elseif sum(abs(copes(j,:)))==0
                copes(j,:)=1;
                EVS{j}='all';
            end
        end
    end
    
    for i=1:size(copes,1)
        for e=1:size(copes,2)
            command=sprintf('%s -e ''s@%s@''%d''@g'' \\\n ',command,sprintf('EV%03d_CON%03d',e,i),copes(i,e));
        end
    end
    
    for j=1:length(EVS)
        command=sprintf('%s -e ''s@%s@''%s''@g'' \\\n ',command,sprintf('EVNAME%03d',j),EVS{j});
    end

    for j=1:length(COPE_names)
        command=sprintf('%s -e ''s@%s@''%s''@g'' \\\n ',command,sprintf('CONTNAME%03d',j),COPE_names{j});
    end
    
    command=sprintf('%s -e ''s@NUMINP@''%d''@g'' \\\n ',command,included);
    command=sprintf('%s -e ''s@NUMEVS_O@''%d''@g'' \\\n ',command,size(contrast,2));
    command=sprintf('%s -e ''s@NUMEVS_R@''%d''@g'' \\\n ',command,size(contrast,2));
    command=sprintf('%s -e ''s@NUMCON@''%d''@g'' \\\n ',command,size(copes,1));
    
    command=sprintf('%s <$i> %s \n done',command,fsf);
    unix(command);
    %%
    % sed '/conmask1_2/,11287d' gFEAT_m4_cue_fail.fsf > holderA.fsf
    % sed '/CONTNAME/,10144d' holderA.fsf > holderB.fsf
    % sed '/groupmem.18/,8818d' holderB.fsf > holderC.fsf
    % sed '/EVNAME/,8518d' holderC.fsf > holderD.fsf
    % sed '/INPUT/,575d' holderD.fsf > holderE.fsf
    % sed '/EV0/{N;d;}' holderE.fsf > gFEAT_m4_cue_fail_clean.fsf
    % rm holder*.fsf
    %%
    cleanup_command=sprintf('sed ''/conmask1_2/,11287d'' %s > %s/holderA.fsf \n', fsf, fsf_clean_out);
    cleanup_command=sprintf('%s sed ''/CONTNAME/,10144d'' %s/holderA.fsf > %s/holderB.fsf \n',cleanup_command, fsf_clean_out, fsf_clean_out);
    cleanup_command=sprintf('%s sed ''/groupmem.%d/,8818d'' %s/holderB.fsf > %s/holderC.fsf \n',cleanup_command,included+1, fsf_clean_out, fsf_clean_out);
    cleanup_command=sprintf('%s sed ''/EVNAME/,8518d'' %s/holderC.fsf > %s/holderD.fsf \n',cleanup_command, fsf_clean_out, fsf_clean_out);
    cleanup_command=sprintf('%s sed ''/INPUT/,575d'' %s/holderD.fsf > %s/holderE.fsf \n',cleanup_command, fsf_clean_out, fsf_clean_out);
    cleanup_command=sprintf('%s sed ''/EV0/{N;d;}'' %s/holderE.fsf > %s \n',cleanup_command, fsf_clean_out, fsf_clean);
    cleanup_command=sprintf('%s rm %s/holder*.fsf',cleanup_command,fsf_clean_out);
    unix(cleanup_command);
    
    
end
toc
end
