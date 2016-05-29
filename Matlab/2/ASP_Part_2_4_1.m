S=5000;                     %num of coefficient pairs 

a=(rand(S,2)-0.5)*[5,0;0,3];%the pairs of coefficnets a1, a2 as column vector

a_stab=[];                  %array to store pairs which preserve stability 
a_unstab=[];                %array to store pairs which are unstable 
p_stab=[];                  %array of the pairs of poles for the stable systems
p_unstab=[];                %array of the pairs of poles for the unstable systems


%creating array of pairs of coeficnets 'a1' 'a2' which form a stable and
%unstable system
for i=1:S,
    
    ai = [1, -a(i,1), -a(i,2)];
    
    if (isstable(1,ai))
        a_stab=[a_stab;[a(i,1), a(i,2)]];
    else
        a_unstab=[a_unstab;[a(i,1), a(i,2)]];
    end
end

%plotting 'a1' on x-axis, 'a2' on y-axis, all stable pairs are green, unstable
%are red.
subplot(1,2,1);
hold on
plot(a_stab(:,1), a_stab(:,2), 'g*')
plot(a_unstab(:,1), a_unstab(:,2), 'r*')
hold off
title('Stability of process plot')
xlabel('a1')
ylabel('a2')


%finding the two poles associated with each pair of coefficnets. If the pair
%of coefficnets is unstable, the both the assoicated poles are plotted red.
%if the pair of coefficnets is stable, both poles are green.
subplot(1,2,2);
d1=size(a_stab);
d2=size(a_unstab);

hold on
for i=1:d1(1,1),
    [r,p,k]=residue([1], [1, -a_stab(i,1), -a_stab(i,2)]); %p is a column vector containg the two poles 
    p_stab=[p_stab; [p']];
end

plot(real(p_stab(:,1)), imag(p_stab(:,1)),'g*', real(p_stab(:,2)), imag(p_stab(:,2)), 'g*')

for i=1:d2(1,1),
    [r,p,k]=residue([1], [1, -a_unstab(i,1), -a_unstab(i,2)]);
    p_unstab=[p_unstab; [p']];
end

plot(real(p_unstab(:,1)), imag(p_unstab(:,1)),'r*', real(p_unstab(:,2)), imag(p_unstab(:,2)), 'r*')

title('Pole location')
xlabel('Real Axis')
ylabel('Imaginary Axis')
axis([-2,2,-2,2])
