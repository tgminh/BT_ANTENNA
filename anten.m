clear; close all; % xóa các window, value lần chạy trước 

lambda = 1; % Bước sóng
% các trường hợp
L_values = [lambda/10, lambda/2, 3*lambda/4, lambda, 1.25*lambda, 1.5*lambda, 2*lambda, 2.5*lambda, 3*lambda];
k = 2 * pi / lambda; % hệ số truyền sóng

theta = linspace(0.01, pi-0.01, 90); % góc θ
phi = linspace(0, 2*pi, 180); % góc φ
[Theta, Phi] = meshgrid(theta, phi); % hệ tọa độ cầu

figure;
set(gcf, 'Color', 'w'); % đặt nền window thành màu trắng

for i = 1:length(L_values)
    L = L_values(i);
    
    % công thức đồ thi bức xạ
    f = abs((cos(k*L/2 .* cos(Theta)) - cos(k*L/2)) ./ sin(Theta));
    %H_phi = E_theta = f; % H_phi vs E_theta khác độ lớn biên độ

    % chuyển đổi sang tọa độ descartes (x, y, z)
    X_E = f .* sin(Theta) .* cos(Phi);
    Y_E = f .* sin(Theta) .* sin(Phi);
    Z_E = f .* cos(Theta);
     
    % vẽ đồ thị 3D
    subplot(3,3,i); % lưới 3x3 để hiển thị cả 9 TH
    surf(X_E, Y_E, Z_E, f.^2, 'EdgeColor', 'none');
    colormap turbo;
    cb = colorbar; % thang màu, tuy nhiên không rõ giá trị gain nên không để các giá trị cụ thể
    cb.TickLabels = [];
    ylabel(cb, 'Gain')

    daspect([1 1 1]); % để làm các trục X, Y, Z đồng nhất nhau

    axis equal; view(3);
    title(sprintf('L = %.2f\\lambda', L/lambda));
    xlabel('X'); ylabel('Y'); zlabel('Z');

end

sgtitle('Bức xạ 3D của Dipole xét E_θ và H_φ');
