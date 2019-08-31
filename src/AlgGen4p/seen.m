function [ is_seen ] = seen( p_bullet, p_player, ang_player, ang_v, ratio )

if(  (p_bullet(1)-p_player(1))^2  +  (p_bullet(2)-p_player(2))^2  < ratio^2 ) % IF 1
    
    ang_player = (ang_player);%wrapTo2Pi(ang_player);
    
    r1 = [cos(ang_v+ang_player) sin(ang_v+ang_player) 0]';
    r2 = [cos(ang_player-ang_v) sin(ang_player-ang_v) 0]';
    
    p1 = [p_bullet(1)-p_player(1) p_bullet(2)-p_player(2) 0]';
   
    
    if( sum(cross(r1,p1)) < 0 && sum(cross(r2,p1)) > 0 )
        is_seen=1;
    else
        is_seen=0;
    end
    
else
    is_seen=0;
end

end

