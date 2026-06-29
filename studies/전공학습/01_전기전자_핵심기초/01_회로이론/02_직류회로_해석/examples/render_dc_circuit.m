function render_dc_circuit(kind, data, outputFile)
%RENDER_DC_CIRCUIT Draw an exact schematic for a worked DC example.

fig = figure(Visible="off", Color="white", Position=[100 100 1100 650]);
ax = axes(fig, Position=[0.04 0.06 0.92 0.88]);
hold(ax, "on");
axis(ax, "equal");
axis(ax, "off");
xlim(ax, [0 10]);
ylim(ax, [0 6]);

switch string(kind)
    case "nodal"
        drawNodal(ax, data);
    case "mesh"
        drawMesh(ax, data);
    case "supernode"
        drawSupernode(ax, data);
    otherwise
        error("Unknown DC circuit kind: %s", kind);
end

exportgraphics(fig, outputFile, Resolution=180, BackgroundColor="white");
close(fig);
end

function drawNodal(ax, data)
yTop = 4.4;
yGround = 0.8;
xSource = 1.0;
xV1 = 4.2;
xV2 = 8.2;

wire(ax, [xSource xSource], [yGround 1.6]);
voltageSourceV(ax, xSource, 1.6, 3.1, data.Vs, true);
wire(ax, [xSource xSource], [3.1 yTop]);
resistorH(ax, xSource, xV1, yTop, data.R(1), "R_1");
node(ax, xV1, yTop);
resistorV(ax, xV1, yTop, yGround, data.R(2), "R_2", "left");
resistorH(ax, xV1, xV2, yTop, data.R(3), "R_3");
node(ax, xV2, yTop);
resistorV(ax, xV2, yTop, yGround, data.R(4), "R_4", "right");
wire(ax, [xSource xV2], [yGround yGround]);
ground(ax, 5.2, yGround);

currentArrow(ax, [2.0 3.2], [4.85 4.85], sprintf("i_{R1}=%.1f mA", data.BranchCurrent(1)*1e3));
currentArrow(ax, [4.65 4.65], [3.7 2.6], sprintf("i_{R2}=%.1f mA", data.BranchCurrent(2)*1e3));
currentArrow(ax, [5.5 6.9], [4.85 4.85], sprintf("i_{R3}=%.1f mA", data.BranchCurrent(3)*1e3));
currentArrow(ax, [8.65 8.65], [3.7 2.6], sprintf("i_{R4}=%.1f mA", data.BranchCurrent(4)*1e3));

text(ax, xV1, 5.25, sprintf("V_1 = %.1f V", data.NodeVoltage(1)), ...
    HorizontalAlignment="center", FontSize=13, FontWeight="bold", Color=[0.05 0.35 0.70]);
text(ax, xV2, 5.25, sprintf("V_2 = %.1f V", data.NodeVoltage(2)), ...
    HorizontalAlignment="center", FontSize=13, FontWeight="bold", Color=[0.05 0.35 0.70]);
text(ax, 5.2, 0.18, "reference node: 0 V", HorizontalAlignment="center", FontSize=11);
title(ax, "Nodal analysis: write KCL at V_1 and V_2", FontSize=17, FontWeight="bold");
end

function drawMesh(ax, data)
yTop = 4.4;
yGround = 0.8;
xLeft = 1.0;
xMid = 4.8;
xRight = 8.8;

wire(ax, [xLeft xLeft], [yGround 1.6]);
voltageSourceV(ax, xLeft, 1.6, 3.1, data.Vs, true);
wire(ax, [xLeft xLeft], [3.1 yTop]);
resistorH(ax, xLeft, xMid, yTop, data.R(1), "R_1");
node(ax, xMid, yTop);
resistorV(ax, xMid, yTop, yGround, data.R(3), "R_3", "left");
resistorH(ax, xMid, xRight, yTop, data.R(2), "R_2");
wire(ax, [xRight xRight], [yTop yGround]);
wire(ax, [xLeft xRight], [yGround yGround]);
ground(ax, 6.7, yGround);

currentArrow(ax, [2.0 3.4], [3.2 3.2], sprintf("i_1=%.3f mA", data.MeshCurrent(1)*1e3));
currentArrow(ax, [5.7 7.2], [3.2 3.2], sprintf("i_2=%.3f mA", data.MeshCurrent(2)*1e3));
currentArrow(ax, [5.25 5.25], [3.7 2.5], ...
    sprintf("i_1-i_2=%.3f mA", data.SharedBranchCurrent*1e3));

text(ax, 2.8, 2.5, "clockwise mesh 1", HorizontalAlignment="center", Color=[0.55 0.10 0.10]);
text(ax, 6.8, 2.5, "clockwise mesh 2", HorizontalAlignment="center", Color=[0.55 0.10 0.10]);
text(ax, 6.7, 0.18, "reference node: 0 V", HorizontalAlignment="center", FontSize=11);
title(ax, "Mesh analysis: shared-resistor drop uses i_1 - i_2", FontSize=17, FontWeight="bold");
end

function drawSupernode(ax, data)
yTop = 4.4;
yGround = 0.8;
xCurrent = 1.0;
xA = 3.2;
xB = 7.2;

wire(ax, [xCurrent xCurrent], [yGround 1.6]);
currentSourceV(ax, xCurrent, 1.6, 3.1, data.Is);
wire(ax, [xCurrent xCurrent], [3.1 yTop]);
wire(ax, [xCurrent xA], [yTop yTop]);
node(ax, xA, yTop);
resistorV(ax, xA, yTop, yGround, data.R(1), "R_1", "left");
voltageSourceH(ax, xA, xB, yTop, data.Vs);
node(ax, xB, yTop);
resistorV(ax, xB, yTop, yGround, data.R(2), "R_2", "right");
wire(ax, [xCurrent xB], [yGround yGround]);
ground(ax, 5.2, yGround);

rectangle(ax, Position=[2.65 3.75 5.1 1.3], Curvature=0.08, ...
    LineStyle="--", LineWidth=1.6, EdgeColor=[0.45 0.20 0.65]);
text(ax, 5.2, 5.25, "supernode boundary", HorizontalAlignment="center", ...
    FontSize=12, FontWeight="bold", Color=[0.45 0.20 0.65]);
currentArrow(ax, [3.65 3.65], [3.7 2.55], sprintf("%.1f mA", data.BranchCurrent(1)*1e3));
currentArrow(ax, [7.65 7.65], [3.7 2.55], sprintf("%.1f mA", data.BranchCurrent(2)*1e3));

text(ax, xA, 5.55, sprintf("V_a = %.1f V", data.NodeVoltage(1)), ...
    HorizontalAlignment="center", FontSize=13, FontWeight="bold", Color=[0.05 0.35 0.70]);
text(ax, xB, 5.55, sprintf("V_b = %.1f V", data.NodeVoltage(2)), ...
    HorizontalAlignment="center", FontSize=13, FontWeight="bold", Color=[0.05 0.35 0.70]);
text(ax, 5.2, 0.18, "reference node: 0 V", HorizontalAlignment="center", FontSize=11);
title(ax, "Supernode analysis: KCL plus V_a - V_b = 5 V", FontSize=17, FontWeight="bold");
end

function resistorH(ax, x1, x2, y, resistance, name)
lead = 0.22*(x2-x1);
xa = x1 + lead;
xb = x2 - lead;
wire(ax, [x1 xa], [y y]);
wire(ax, [xb x2], [y y]);
x = linspace(xa, xb, 10);
offset = [0 0.20 -0.20 0.20 -0.20 0.20 -0.20 0.20 -0.20 0];
plot(ax, x, y+offset, Color="black", LineWidth=1.8);
text(ax, (x1+x2)/2, y+0.48, sprintf("%s = %s", name, formatResistance(resistance)), ...
    HorizontalAlignment="center", FontSize=11, Interpreter="tex");
end

function resistorV(ax, x, y1, y2, resistance, name, side)
lead = 0.20*(y1-y2);
ya = y1 - lead;
yb = y2 + lead;
wire(ax, [x x], [y1 ya]);
wire(ax, [x x], [yb y2]);
y = linspace(ya, yb, 10);
offset = [0 0.20 -0.20 0.20 -0.20 0.20 -0.20 0.20 -0.20 0];
plot(ax, x+offset, y, Color="black", LineWidth=1.8);
if side == "left"
    xText = x-0.55;
    alignment = "right";
else
    xText = x+0.55;
    alignment = "left";
end
text(ax, xText, (y1+y2)/2, sprintf("%s = %s", name, formatResistance(resistance)), ...
    HorizontalAlignment=alignment, FontSize=11, Interpreter="tex");
end

function voltageSourceV(ax, x, y1, y2, voltage, positiveTop)
center = (y1+y2)/2;
radius = 0.48;
wire(ax, [x x], [y1 center-radius]);
wire(ax, [x x], [center+radius y2]);
rectangle(ax, Position=[x-radius center-radius 2*radius 2*radius], ...
    Curvature=[1 1], EdgeColor="black", LineWidth=1.8);
if positiveTop
    text(ax, x, center+0.19, "+", HorizontalAlignment="center", FontSize=15);
    text(ax, x, center-0.22, "-", HorizontalAlignment="center", FontSize=15);
else
    text(ax, x, center+0.19, "-", HorizontalAlignment="center", FontSize=15);
    text(ax, x, center-0.22, "+", HorizontalAlignment="center", FontSize=15);
end
text(ax, x-0.72, center, sprintf("V_s = %.0f V", voltage), ...
    HorizontalAlignment="right", FontSize=11, Interpreter="tex");
end

function voltageSourceH(ax, x1, x2, y, voltage)
center = (x1+x2)/2;
radius = 0.48;
wire(ax, [x1 center-radius], [y y]);
wire(ax, [center+radius x2], [y y]);
rectangle(ax, Position=[center-radius y-radius 2*radius 2*radius], ...
    Curvature=[1 1], EdgeColor="black", LineWidth=1.8);
text(ax, center-0.20, y, "+", HorizontalAlignment="center", FontSize=15);
text(ax, center+0.20, y, "-", HorizontalAlignment="center", FontSize=15);
text(ax, center, y-0.78, sprintf("V_s = %.0f V", voltage), ...
    HorizontalAlignment="center", FontSize=11, Interpreter="tex");
end

function currentSourceV(ax, x, y1, y2, current)
center = (y1+y2)/2;
radius = 0.48;
wire(ax, [x x], [y1 center-radius]);
wire(ax, [x x], [center+radius y2]);
rectangle(ax, Position=[x-radius center-radius 2*radius 2*radius], ...
    Curvature=[1 1], EdgeColor="black", LineWidth=1.8);
quiver(ax, x, center-0.24, 0, 0.48, 0, Color=[0.70 0.12 0.12], ...
    LineWidth=1.8, MaxHeadSize=0.7);
text(ax, x-0.72, center, sprintf("I_s = %.0f mA", current*1e3), ...
    HorizontalAlignment="right", FontSize=11, Interpreter="tex");
end

function currentArrow(ax, x, y, label)
quiver(ax, x(1), y(1), x(2)-x(1), y(2)-y(1), 0, ...
    Color=[0.75 0.12 0.12], LineWidth=1.5, MaxHeadSize=0.35);
text(ax, mean(x), mean(y)+0.24, label, HorizontalAlignment="center", ...
    FontSize=10, Color=[0.60 0.08 0.08], Interpreter="tex");
end

function node(ax, x, y)
scatter(ax, x, y, 54, [0.05 0.35 0.70], "filled");
end

function ground(ax, x, y)
wire(ax, [x x], [y y-0.18]);
plot(ax, [x-0.34 x+0.34], [y-0.18 y-0.18], Color="black", LineWidth=1.5);
plot(ax, [x-0.23 x+0.23], [y-0.30 y-0.30], Color="black", LineWidth=1.5);
plot(ax, [x-0.11 x+0.11], [y-0.42 y-0.42], Color="black", LineWidth=1.5);
end

function wire(ax, x, y)
plot(ax, x, y, Color="black", LineWidth=1.8);
end

function label = formatResistance(resistance)
if resistance >= 1e3
    label = sprintf("%.0f k\\Omega", resistance/1e3);
else
    label = sprintf("%.0f \\Omega", resistance);
end
end
