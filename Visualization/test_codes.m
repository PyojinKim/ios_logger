

delimiter = ',';
textFileName = 'ARposes.txt';
textFileDir = [datasetPath '/' textFileName];
textARposeData = importdata(textFileDir, delimiter);

ARposes.time = textARposeData(:,1).';
ARposes.p_gc = [textARposeData(:,2).'; textARposeData(:,3).'; textARposeData(:,4).'];
ARposes.q_gc = [textARposeData(:,5).'; textARposeData(:,6).'; textARposeData(:,7).'; textARposeData(:,8).'];
numARposes = size(textARposeData,1);


% plot update rate of ARKit camera pose
timeDifference = diff(ARposes.time);
meanUpdateRate = (1/mean(timeDifference));
figure;
plot(ARposes.time(2:end), timeDifference, 'm'); hold on; grid on; axis tight;
set(gcf,'color','w'); hold off;
axis([min(ARKitPoseTime) max(ARKitPoseTime) min(timeDifference) max(timeDifference)]);
set(get(gcf,'CurrentAxes'),'FontName','Times New Roman','FontSize',17);
xlabel('Time [sec]','FontName','Times New Roman','FontSize',17);
ylabel('Time Difference [sec]','FontName','Times New Roman','FontSize',17);
title(['Mean Update Rate: ', num2str(meanUpdateRate), ' Hz'],'FontName','Times New Roman','FontSize',17);
set(gcf,'Units','pixels','Position',[100 200 1800 900]);  % modify figure


%%

% 2) plot ARKit VIO motion estimation results
figure;
h_ARKit = plot3(stateEsti_ARKit(1,:),stateEsti_ARKit(2,:),stateEsti_ARKit(3,:),'m','LineWidth',2); hold on; grid on;
scatter3(ARKitPoints(1,:), ARKitPoints(2,:), ARKitPoints(3,:), 40*ones(numPoints,1), (ARKitColors ./ 255).','.');
plot_inertial_frame(0.5); legend(h_ARKit,{'ARKit'}); axis equal; view(26, 73);
xlabel('x [m]','fontsize',10); ylabel('y [m]','fontsize',10); zlabel('z [m]','fontsize',10); hold off;

% figure options
f = FigureRotator(gca());





