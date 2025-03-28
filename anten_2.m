clear; close all; clc; % Xóa bộ nhớ, đóng cửa sổ đồ thị và xóa màn hình lệnh

lambda = 1; % Bước sóng
L_values = [lambda/10, lambda/2, 3*lambda/4, lambda, 1.25*lambda, 1.5*lambda, 2*lambda, 2.5*lambda, 3*lambda];
k = 2 * pi / lambda; % Hằng số sóng

theta = linspace(0.01, pi-0.01, 90); % Góc θ (tránh 0 và pi để không bị lỗi chia cho 0)
phi = linspace(0, 2*pi, 180); % Góc φ
[Theta, Phi] = meshgrid(theta, phi); % Hệ tọa độ cầu

for i = 1:length(L_values)
    L = L_values(i);
    
    % Công thức bức xạ
    f = abs((cos(k*L/2 .* cos(Theta)) - cos(k*L/2)) ./ sin(Theta));

    % Chuyển đổi sang tọa độ Descartes (x, y, z)
    X_E = f .* sin(Theta) .* cos(Phi);
    Y_E = f .* sin(Theta) .* sin(Phi);
    Z_E = f .* cos(Theta);
  
    % Mở cửa sổ figure mới
    figure('Color', 'w'); % Nền trắng

    % Vẽ đồ thị 3D
    surf(X_E, Y_E, Z_E, f.^2, 'EdgeColor', 'none'); % Màu theo công suất bức xạ
    colormap turbo; % Bảng màu 

    % Định dạng trục
    daspect([1 1 1]); % Đặt tỷ lệ các trục X, Y, Z bằng nhau
    axis equal;
    view(3); % Góc nhìn 3D

    
    % Nhãn và tiêu đề
    title(sprintf('L = %.2f\\lambda', L/lambda));
    xlabel('X'); ylabel('Y'); zlabel('Z');
end
