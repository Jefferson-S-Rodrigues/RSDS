function [ks] = plotarLGR(FT, zwn, wn, b, limx, limy)
% Plota LGR com RSDS.
%   ks = os ganhos da LGR (retorno).
%   FT = a função de transferência já em MF
%   zwn = o valor de - zeta * wn (reta vertical da RSDS)
%   wn = o valor do raio do círculo da RSDS
%   b = o ângulo beta, para retas inclinadas da RSDS
%   limx e limy = limites do gráfico, exemplo limx = [-9 1]; limy = [-5 5]

colortab = [[0, 0.4470, 0.7410]
          	[0.8500, 0.3250, 0.0980]
          	[0.9290, 0.6940, 0.1250]
          	[0.4940, 0.1840, 0.5560]
          	[0.4660, 0.6740, 0.1880]
          	[0.3010, 0.7450, 0.9330]
          	[0.6350, 0.0780, 0.1840]];

% Root Locus
[lgrs, ks] = rlocus(FT);
pFT = pole(FT);
zFT = zero(FT);

[dimr, ~] = size(lgrs);

% Círculo de wn
xc = 0;
yc = 0;

theta = linspace(pi / 2, 3 * pi / 2);

xcirc = wn * cos(theta) + xc;
ycirc = wn * sin(theta) + yc;

% Transforma em ângulo
b1 = pi - (b / 180 * pi);
b2 = pi + (b / 180 * pi);

m1 = tan(b1);
m2 = tan(b2);

hold on
%is not a valid value. Use one of these values: '-' | '--' | ':' | '-.' | 'none'.
line([limx(1) limx(2)],[0 0], 'Color', colortab(6,:), 'Linestyle', '--')
line([0 0],[limy(1) limy(2)], 'Color', colortab(6,:), 'Linestyle', '--')

%Linha vertical de zeta wn
line([zwn zwn],[limy(1) limy(2)], 'Color', colortab(7,:), 'Linestyle', ':')
%Semicírculo
plot(xcirc, ycirc, 'Color', colortab(7,:), 'Linestyle', ':')
%retas
line([limx(1) 0],[(m1 * limx(1)) 0], 'Color', colortab(7,:), 'Linestyle', ':')
line([limx(1) 0],[(m2 * limx(1)) 0], 'Color', colortab(7,:), 'Linestyle', ':')

%polos e zeros
for i = 1:length(pFT)
    scatter(pFT(i),0,'x')
end
for i = 1:length(zFT)
    scatter(zFT(i),0,'o')
end

%LGR
for i = 1:dimr
    plot(real(lgrs(i,:)),imag(lgrs(i,:)), 'Color', colortab(i,:))
end

title('RSDS')
xlabel('Eixo Real')
ylabel('Eixo Imaginário')
xlim(limx)
ylim(limy)

hold off
