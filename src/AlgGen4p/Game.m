clear
clc

tic

% number of initial population
fighters = 20;
% number of generations
generations = 50;

% Create random weigths for the initial population
population = 20*rand(generations+1,fighters,70)-10;

for generation = 1:generations
    generation
    for match=1:fighters/4
       
        % Start not doing anything
        forward1 = 0;
        right1 = 0;
        left1 = 0;
        shoot1 = 0;
        wider_field_vis1=0;
        forward2 = 0;
        right2 = 0;
        left2 = 0;
        shoot2 = 0;
        wider_field_vis2 = 0;        
        forward3 = 0;
        right3 = 0;
        left3 = 0;
        shoot3 = 0;
        wider_field_vis3=0;
        forward4 = 0;
        right4 = 0;
        left4 = 0;
        shoot4 = 0;
        wider_field_vis4 = 0;
        
        
        % Start position
        p1_pos =[100 100];
        p1_ang = -3*pi/4;
        p2_pos =[100 400];
        p2_ang = 3*pi/4;
        p3_pos =[400 400];
        p3_ang = pi/4;
        p4_pos =[100 400];
        p4_ang = -pi/4;
        ang_v1 = pi/36;
        ang_v2 = pi/36;
        ang_v3 = pi/36;
        ang_v4 = pi/36;        
        
        % No bullets at the beginning        
        bullet_1_exist = 0;
        bullet_2_exist = 0;
        bullet_3_exist = 0;
        bullet_4_exist = 0;        
        bullet1_pos = [-100 -100];
        bullet2_pos = [-100 -100];
        bullet3_pos = [-100 -100];
        bullet4_pos = [-100 -100];        
        bullet1_ang =0;
        bullet2_ang =0;
        bullet3_ang =0;
        bullet4_ang =0;        
        
        % No score at the beginning
        score1 = 0;
        score2 = 0;
        score3 = 0;
        score4 = 0;
        
        % for each four players, get the DNA and put in weight format
        DNA1 = population(generation,match*4,:);
        DNA2 = population(generation,match*4-1,:);
        DNA3 = population(generation,match*4-2,:);
        DNA4 = population(generation,match*4-3,:);
        weight1 = {[DNA1(1:5); DNA1(6:10); DNA1(11:15); DNA1(16:20)] [DNA1(21:25);DNA1(26:30); DNA1(31:35); DNA1(36:40); DNA1(41:45)] [ DNA1(46:50);DNA1(51:55); DNA1(56:60); DNA1(61:65); DNA1(66:70)]};
        weight2 = {[DNA2(1:5); DNA2(6:10); DNA2(11:15); DNA2(16:20)] [DNA2(21:25);DNA2(26:30); DNA2(31:35); DNA2(36:40); DNA2(41:45)] [ DNA2(46:50);DNA2(51:55); DNA2(56:60); DNA2(61:65); DNA2(66:70)]};
        weight3 = {[DNA3(1:5); DNA3(6:10); DNA3(11:15); DNA3(16:20)] [DNA3(21:25);DNA3(26:30); DNA3(31:35); DNA3(36:40); DNA3(41:45)] [ DNA3(46:50);DNA3(51:55); DNA3(56:60); DNA3(61:65); DNA3(66:70)]};
        weight4 = {[DNA4(1:5); DNA4(6:10); DNA4(11:15); DNA4(16:20)] [DNA4(21:25);DNA4(26:30); DNA4(31:35); DNA4(36:40); DNA4(41:45)] [ DNA4(46:50);DNA4(51:55); DNA4(56:60); DNA4(61:65); DNA4(66:70)]};
   
        % Ready, steady, go        
        for turn= 1:1000
            
            % Is enemy seen?
            p1_ene_v = seen( p2_pos, p1_pos, p1_ang, ang_v1, 9000 ) || seen( p3_pos, p1_pos, p1_ang, ang_v1, 9000 ) || seen( p4_pos, p1_pos, p1_ang, ang_v1, 9000 );
            p2_ene_v = seen( p1_pos, p2_pos, p2_ang, ang_v2, 9000 ) || seen( p3_pos, p2_pos, p2_ang, ang_v2, 9000 ) || seen( p4_pos, p2_pos, p2_ang, ang_v2, 9000 );
            p3_ene_v = seen( p1_pos, p3_pos, p3_ang, ang_v3, 9000 ) || seen( p2_pos, p3_pos, p3_ang, ang_v3, 9000 ) || seen( p4_pos, p3_pos, p3_ang, ang_v3, 9000 );
            p4_ene_v = seen( p1_pos, p4_pos, p4_ang, ang_v4, 9000 ) || seen( p2_pos, p4_pos, p4_ang, ang_v4, 9000 ) || seen( p3_pos, p4_pos, p4_ang, ang_v4, 9000 );
            % Is enemy bullet seen?
            p1_bullet_v = seen( bullet2_pos, p1_pos, p1_ang, ang_v1, 9000 ) || seen( bullet3_pos, p1_pos, p1_ang, ang_v1, 9000 ) || seen( bullet4_pos, p1_pos, p1_ang, ang_v1, 9000 );
            p2_bullet_v = seen( bullet1_pos, p2_pos, p2_ang, ang_v2, 9000 ) || seen( bullet3_pos, p2_pos, p2_ang, ang_v2, 9000 ) || seen( bullet4_pos, p2_pos, p2_ang, ang_v2, 9000 );
            p3_bullet_v = seen( bullet1_pos, p3_pos, p3_ang, ang_v3, 9000 ) || seen( bullet2_pos, p3_pos, p3_ang, ang_v3, 9000 ) || seen( bullet4_pos, p3_pos, p3_ang, ang_v3, 9000 );
            p4_bullet_v = seen( bullet1_pos, p4_pos, p4_ang, ang_v4, 9000 ) || seen( bullet2_pos, p4_pos, p4_ang, ang_v4, 9000 ) || seen( bullet3_pos, p4_pos, p4_ang, ang_v4, 9000 );
            
            % Extract the action with this inputs
            action1 = nn([4,5,5], weight1, [p1_ene_v p1_bullet_v ~bullet_1_exist ang_v1]);
            action2 = nn([4,5,5], weight2, [p2_ene_v p2_bullet_v ~bullet_2_exist ang_v2]);
            action3 = nn([4,5,5], weight3, [p3_ene_v p3_bullet_v ~bullet_3_exist ang_v3]);
            action4 = nn([4,5,5], weight4, [p4_ene_v p4_bullet_v ~bullet_4_exist ang_v4]);
            
            % Do your moves
            forward1 = round(action1(1));
            right1 = round(action1(2));
            left1 = round(action1(3));
            shoot1 = round(action1(4));
            wider_field_vis1 = 2*action1(5)-1;
            forward2 = round(action2(1));
            right2 = round(action2(2));
            left2 = round(action2(3));
            shoot2 = round(action2(4));
            wider_field_vis2 = 2*action2(5)-1;
            forward3 = round(action3(1));
            right3 = round(action3(2));
            left3 = round(action3(3));
            shoot3 = round(action3(4));
            wider_field_vis3 = 2*action3(5)-1;
            forward4 = round(action4(1));
            right4 = round(action4(2));
            left4 = round(action4(3));
            shoot4 = round(action4(4));
            wider_field_vis4 = 2*action4(5)-1;            
            
            
            % Game rules
            if(forward1 == 1),p1_pos = p1_pos + [cos(p1_ang) sin(p1_ang)];end
            if(right1 == 1),p1_ang = p1_ang - pi/72; end
            if(left1 == 1),p1_ang = p1_ang + pi/72; end
            if(shoot1 == 1 && bullet_1_exist == 0),bullet1_pos = p1_pos; bullet1_ang = p1_ang; bullet_1_exist = 1; end
            ang_v1 = ang_v1 + wider_field_vis1 * pi/72;
            if(bullet_1_exist == 1), bullet1_pos = bullet1_pos + 5*[cos(bullet1_ang) sin(bullet1_ang)];end
            if((p1_pos(1)-bullet2_pos(1))*(p1_pos(1)-bullet2_pos(1))+(p1_pos(2)-bullet2_pos(2))*(p1_pos(2)-bullet2_pos(2))<400)
                bullet_2_exist = 0; score2 = score2+1; score1 = score1-1; bullet2_pos = [-100 -100]; end
            if((p1_pos(1)-bullet3_pos(1))*(p1_pos(1)-bullet3_pos(1))+(p1_pos(2)-bullet3_pos(2))*(p1_pos(2)-bullet3_pos(2))<400)
                bullet_3_exist = 0; score3 = score3+1; score1 = score1-1; bullet3_pos = [-100 -100]; end
            if((p1_pos(1)-bullet4_pos(1))*(p1_pos(1)-bullet4_pos(1))+(p1_pos(2)-bullet4_pos(2))*(p1_pos(2)-bullet4_pos(2))<400)
                bullet_4_exist = 0; score4 = score4+1; score1 = score1-1; bullet4_pos = [-100 -100]; end
            
            if(forward2 == 1),p2_pos = p2_pos + [cos(p2_ang) sin(p2_ang)];end
            if(right2 == 1),p2_ang = p2_ang - pi/72; end
            if(left2 == 1),p2_ang = p2_ang + pi/72; end
            if(shoot2 == 1 && bullet_2_exist == 0),bullet2_pos = p2_pos; bullet2_ang = p2_ang; bullet_2_exist = 1; end
            ang_v2 = ang_v2 + wider_field_vis2 * pi/72;
            if(bullet_2_exist == 1), bullet2_pos = bullet2_pos + 5*[cos(bullet2_ang) sin(bullet2_ang)];end
            if((p2_pos(1)-bullet1_pos(1))*(p2_pos(1)-bullet1_pos(1))+(p2_pos(2)-bullet1_pos(2))*(p2_pos(2)-bullet1_pos(2))<400)
                bullet_1_exist = 0; score1 = score1+1; score2 = score2-1; bullet1_pos = [-100 -100]; end
            if((p2_pos(1)-bullet3_pos(1))*(p2_pos(1)-bullet3_pos(1))+(p2_pos(2)-bullet3_pos(2))*(p2_pos(2)-bullet3_pos(2))<400)
                bullet_3_exist = 0; score3 = score3+1; score2 = score2-1; bullet3_pos = [-100 -100]; end
            if((p2_pos(1)-bullet4_pos(1))*(p2_pos(1)-bullet4_pos(1))+(p2_pos(2)-bullet4_pos(2))*(p2_pos(2)-bullet4_pos(2))<400)
                bullet_4_exist = 0; score4 = score4+1; score2 = score2-1; bullet4_pos = [-100 -100]; end
            
            if(forward3 == 1),p3_pos = p3_pos + [cos(p3_ang) sin(p3_ang)];end
            if(right3 == 1),p3_ang = p3_ang - pi/72; end
            if(left3 == 1),p3_ang = p3_ang + pi/72; end
            if(shoot3 == 1 && bullet_3_exist == 0),bullet3_pos = p3_pos; bullet3_ang = p3_ang; bullet_3_exist = 1; end
            ang_v3 = ang_v3 + wider_field_vis3 * pi/72;
            if(bullet_3_exist == 1), bullet3_pos = bullet3_pos + 5*[cos(bullet3_ang) sin(bullet3_ang)];end
            if((p3_pos(1)-bullet1_pos(1))*(p3_pos(1)-bullet1_pos(1))+(p3_pos(2)-bullet1_pos(2))*(p3_pos(2)-bullet1_pos(2))<400)
                bullet_1_exist = 0; score1 = score1+1; score3 = score3-1; bullet1_pos = [-100 -100]; end
            if((p3_pos(1)-bullet2_pos(1))*(p3_pos(1)-bullet2_pos(1))+(p3_pos(2)-bullet2_pos(2))*(p3_pos(2)-bullet2_pos(2))<400)
                bullet_2_exist = 0; score2 = score2+1; score3 = score3-1; bullet2_pos = [-100 -100]; end
            if((p3_pos(1)-bullet4_pos(1))*(p3_pos(1)-bullet4_pos(1))+(p3_pos(2)-bullet4_pos(2))*(p3_pos(2)-bullet4_pos(2))<400)
                bullet_4_exist = 0; score4 = score4+1; score3 = score3-1; bullet4_pos = [-100 -100]; end
            
            if(forward4 == 1),p4_pos = p4_pos + [cos(p4_ang) sin(p4_ang)];end
            if(right4 == 1),p4_ang = p4_ang - pi/72; end
            if(left4 == 1),p4_ang = p4_ang + pi/72; end
            if(shoot4 == 1 && bullet_4_exist == 0),bullet4_pos = p4_pos; bullet4_ang = p4_ang; bullet_4_exist = 1; end
            ang_v4 = ang_v4 + wider_field_vis4 * pi/72;
            if(bullet_4_exist == 1), bullet4_pos = bullet4_pos + 5*[cos(bullet4_ang) sin(bullet4_ang)];end
            if((p4_pos(1)-bullet1_pos(1))*(p4_pos(1)-bullet1_pos(1))+(p4_pos(2)-bullet1_pos(2))*(p4_pos(2)-bullet1_pos(2))<400)
                bullet_1_exist = 0; score1 = score1+1; score4 = score4-1; bullet1_pos = [-100 -100]; end
            if((p4_pos(1)-bullet2_pos(1))*(p4_pos(1)-bullet2_pos(1))+(p4_pos(2)-bullet2_pos(2))*(p4_pos(2)-bullet2_pos(2))<400)
                bullet_2_exist = 0; score2 = score2+1; score4 = score4-1; bullet2_pos = [-100 -100]; end
            if((p4_pos(1)-bullet3_pos(1))*(p4_pos(1)-bullet3_pos(1))+(p4_pos(2)-bullet3_pos(2))*(p4_pos(2)-bullet3_pos(2))<400)
                bullet_3_exist = 0; score3 = score3+1; score4 = score4-1; bullet3_pos = [-100 -100]; end
            
            %  boundary of the match
            if(p1_pos(1)>200),p1_pos(1)=200;end
            if(p1_pos(2)>200),p1_pos(2)=200;end
            if(p1_pos(1)<0),p1_pos(1)=0;end
            if(p1_pos(2)<0),p1_pos(2)=0;end
            if(p2_pos(1)>200),p2_pos(1)=200;end
            if(p2_pos(2)>500),p2_pos(2)=500;end
            if(p2_pos(1)<0),p2_pos(1)=0;end
            if(p2_pos(2)<300),p2_pos(2)=300;end
            if(p3_pos(1)>500),p3_pos(1)=500;end
            if(p3_pos(2)>500),p3_pos(2)=500;end
            if(p3_pos(1)<300),p3_pos(1)=300;end
            if(p3_pos(2)<300),p3_pos(2)=300;end
            if(p4_pos(1)>500),p4_pos(1)=500;end
            if(p4_pos(2)>200),p4_pos(2)=200;end
            if(p4_pos(1)<300),p4_pos(1)=300;end
            if(p4_pos(2)<0),p4_pos(2)=0;end
            
            if(bullet1_pos(1)<0),bullet_1_exist=0;bullet1_pos = [-100 -100];end
            if(bullet1_pos(2)<0),bullet_1_exist=0;bullet1_pos = [-100 -100];end
            if(bullet1_pos(1)>500),bullet_1_exist=0;bullet1_pos = [-100 -100];end
            if(bullet1_pos(2)>500),bullet_1_exist=0;bullet1_pos = [-100 -100];end
            if(bullet2_pos(1)<0),bullet_2_exist=0;bullet2_pos = [-100 -100];end
            if(bullet2_pos(2)<0),bullet_2_exist=0;bullet2_pos = [-100 -100];end
            if(bullet2_pos(1)>500),bullet_2_exist=0;bullet2_pos = [-100 -100];end
            if(bullet2_pos(2)>500),bullet_2_exist=0;bullet2_pos = [-100 -100];end
            if(bullet3_pos(1)<0),bullet_3_exist=0;bullet3_pos = [-100 -100];end
            if(bullet3_pos(2)<0),bullet_3_exist=0;bullet3_pos = [-100 -100];end
            if(bullet3_pos(1)>500),bullet_3_exist=0;bullet3_pos = [-100 -100];end
            if(bullet3_pos(2)>500),bullet_3_exist=0;bullet3_pos = [-100 -100];end
            if(bullet4_pos(1)<0),bullet_4_exist=0;bullet4_pos = [-100 -100];end
            if(bullet4_pos(2)<0),bullet_4_exist=0;bullet4_pos = [-100 -100];end
            if(bullet4_pos(1)>500),bullet_4_exist=0;bullet4_pos = [-100 -100];end
            if(bullet4_pos(2)>500),bullet_4_exist=0;bullet4_pos = [-100 -100];end
           
            if(ang_v1>pi/18),ang_v1=pi/18;end
            if(ang_v2>pi/18),ang_v2=pi/18;end
            if(ang_v3>pi/18),ang_v3=pi/18;end
            if(ang_v4>pi/18),ang_v4=pi/18;end
            if(ang_v1<pi/100),ang_v1=pi/100;end
            if(ang_v2<pi/100),ang_v2=pi/100;end
            if(ang_v3<pi/100),ang_v3=pi/100;end
            if(ang_v4<pi/100),ang_v4=pi/100;end
  
        end
        
        % Fighter with better score survive, Coliseum style
        [smax,id] = max([score1,score2,score3,score4]);
        population(generation+1,match,:)= population(generation,match*4-id+1,:); score(generation,match) = smax;
    end
    
    % Winner fighters have children mixing their DNA randomly
    for crossover=1:3*fighters/4
        mix=round(rand(1,1,70));
        population(generation+1,fighters/4+crossover,:)= population(generation+1,ceil(fighters/4*rand()),:).*mix+population(generation+1,ceil(fighters/4*rand()),:).*(~mix);
    end
 
    % Children get a random gen
    for mutated=1:3*fighters/4
        population(generation+1,3*fighters/4+mutated,ceil(rand()*70))= 20*rand()-10;
    end
end

toc