extends Node

class Cell:
    var north_id: String
    var north_east_id: String
    var east_id: String
    var south_east_id: String
    var south_id: String
    var south_west_id: String
    var west_id: String
    var north_west_id: String
    var scene_path: String
    var scene_parameters
    
    func _init(north: String, north_east: String, east: String, south_east: String, 
               south: String, south_west: String, west: String, north_west: String,
               path: String, parameters):
                north_id = north
                north_east_id = north_east
                east_id = east
                south_east_id = south_east
                south_id = south
                south_west_id = south_west
                west_id = west
                north_west_id = north_west
                scene_path = path
                scene_parameters = parameters
    func create():
        var room: Spatial = load(scene_path).instance()
        room.set_parameters(scene_parameters)
        return room

#This is a geometric representation of the path:
#
#   A0  A1  A2  A3
# B0  B1  B2  B3  
#   C0  C1  C2  C3
# D0  D1  D2  D3  
#   E0  E1  E2  E3
# F0  F1  F2  F3  
#   G0  G1  G2  G3
# H0  H1  H2  H3  


var map = {
        #              Up   Up-R  Right Dwn-R Down  Dwn-L Left  Up-L
        "A0":Cell.new("G0", "H1", "A1", "B1", "C0", "B0", "A3", "H0", "res://Rooms/BaseRoom.tscn",
                    Color.aliceblue),
        "A1":Cell.new("G1", "H2", "A2", "B2", "C1", "B1", "A0", "H1", "res://Rooms/BaseRoom.tscn",
                    Color.antiquewhite),
        "A2":Cell.new("G2", "H3", "A3", "B3", "C2", "B2", "A1", "H2", "res://Rooms/BaseRoom.tscn",
                    Color.aqua),
        "A3":Cell.new("G3", "H0", "A0", "B0", "C3", "B3", "A2", "H3", "res://Rooms/BaseRoom.tscn",
                    Color.aquamarine),
        "B0":Cell.new("H0", "A0", "B1", "C0", "D0", "C3", "B3", "A3", "res://Rooms/BaseRoom.tscn",
                    Color.azure),
        "B1":Cell.new("H1", "A1", "B2", "C1", "D1", "C0", "B0", "A0", "res://Rooms/BaseRoom.tscn",
                    Color.beige),
        "B2":Cell.new("H2", "A2", "B3", "C2", "D2", "C1", "B1", "A1", "res://Rooms/BaseRoom.tscn",
                    Color.bisque),
        "B3":Cell.new("H3", "A3", "B0", "C3", "D3", "C2", "B2", "A2", "res://Rooms/BaseRoom.tscn",
                    Color.black),
        "C0":Cell.new("A0", "B1", "C1", "D1", "E0", "D0", "C3", "B0", "res://Rooms/BaseRoom.tscn",
                    Color.blanchedalmond),
        "C1":Cell.new("A1", "B2", "C2", "D2", "E1", "D1", "C0", "B1", "res://Rooms/BaseRoom.tscn",
                    Color.blue),
        "C2":Cell.new("A2", "B3", "C3", "D3", "E2", "D2", "C1", "B2", "res://Rooms/BaseRoom.tscn",
                    Color.blueviolet),
        "C3":Cell.new("A3", "B0", "C0", "D0", "E3", "D3", "C2", "B3", "res://Rooms/BaseRoom.tscn",
                    Color.brown),
        "D0":Cell.new("B0", "C0", "D1", "E0", "F0", "E3", "D3", "C3", "res://Rooms/BaseRoom.tscn",
                    Color.burlywood),
        "D1":Cell.new("B1", "C1", "D2", "E1", "F1", "E0", "D0", "C0", "res://Rooms/BaseRoom.tscn",
                    Color.cadetblue),
        "D2":Cell.new("B2", "C2", "D3", "E2", "F2", "E1", "D1", "C1", "res://Rooms/BaseRoom.tscn",
                    Color.chartreuse),
        "D3":Cell.new("B3", "C3", "D0", "E3", "F3", "E2", "D2", "C2", "res://Rooms/BaseRoom.tscn",
                    Color.chocolate),
        "E0":Cell.new("C0", "D1", "E1", "F1", "G0", "F0", "E3", "D0", "res://Rooms/BaseRoom.tscn",
                    Color.coral),
        "E1":Cell.new("C1", "D2", "E2", "F2", "G1", "F1", "E0", "D1", "res://Rooms/BaseRoom.tscn",
                    Color.cornflower),
        "E2":Cell.new("C2", "D3", "E3", "F3", "G2", "F2", "E1", "D2", "res://Rooms/BaseRoom.tscn",
                    Color.cornsilk),
        "E3":Cell.new("C3", "D0", "E0", "F0", "G3", "F3", "E2", "D3", "res://Rooms/BaseRoom.tscn",
                    Color.crimson),
        "F0":Cell.new("D0", "E0", "F1", "G0", "H0", "G3", "F3", "E3", "res://Rooms/BaseRoom.tscn",
                    Color.cyan),
        "F1":Cell.new("D1", "E1", "F2", "G1", "H1", "G0", "F0", "E0", "res://Rooms/BaseRoom.tscn",
                    Color.firebrick),
        "F2":Cell.new("D2", "E2", "F3", "G2", "H2", "G1", "F1", "E1", "res://Rooms/BaseRoom.tscn",
                    Color.floralwhite),
        "F3":Cell.new("D3", "E3", "F0", "G3", "H3", "G2", "F2", "E2", "res://Rooms/BaseRoom.tscn",
                    Color.forestgreen),
        "G0":Cell.new("E0", "F1", "G1", "H1", "A0", "H0", "G3", "F0", "res://Rooms/BaseRoom.tscn",
                    Color.fuchsia),
        "G1":Cell.new("E1", "F2", "G2", "H2", "A1", "H1", "G0", "F1", "res://Rooms/BaseRoom.tscn",
                    Color.gainsboro),
        "G2":Cell.new("E2", "F3", "G3", "H3", "A2", "H2", "G1", "F2", "res://Rooms/BaseRoom.tscn",
                    Color.ghostwhite),
        "G3":Cell.new("E3", "F0", "G0", "H0", "A3", "H3", "G2", "F3", "res://Rooms/BaseRoom.tscn",
                    Color.gold),
        "H0":Cell.new("F0", "G0", "H1", "A0", "B0", "A3", "H3", "G3", "res://Rooms/BaseRoom.tscn",
                    Color.goldenrod),
        "H1":Cell.new("F1", "G1", "H2", "A1", "B1", "A0", "H0", "G0", "res://Rooms/BaseRoom.tscn",
                    Color.gray),
        "H2":Cell.new("F2", "G2", "H3", "A2", "B2", "A1", "H1", "G1", "res://Rooms/BaseRoom.tscn",
                    Color.green),
        "H3":Cell.new("F3", "G3", "H0", "A3", "B3", "A2", "H2", "G2", "res://Rooms/BaseRoom.tscn",
                    Color.greenyellow)
   }


# This is the most we could do with this grid system, though our program should be able to handle more without trouble.
#
#   A0  A1  A2  A3  A4  A5  A6  A7  A8  A9
# B0  B1  B2  B3  B4  B5  B6  B7  B8  B9
#   C0  C1  C2  C3  C4  C5  C6  C7  C8  C9
# D0  D1  D2  D3  D4  D5  D6  D7  D8  D9
#   E0  E1  E2  E3  E4  E5  E6  E7  E8  E9
# F0  F1  F2  F3  F4  F5  F6  F7  F8  F9
#   G0  G1  G2  G3  G4  G5  G6  G7  G8  G9
# H0  H1  H2  H3  H4  H5  H6  H7  H8  H9
#   I0  I1  I2  I3  I4  I5  I6  I7  I8  I9
# J0  J1  J2  J3  J4  J5  J6  J7  J8  J9
#   K0  K1  K2  K3  K4  K5  K6  K7  K8  K9
# L0  L1  L2  L3  L4  L5  L6  L7  L8  L9
#   M0  M1  M2  M3  M4  M5  M6  M7  M8  M9
# N0  N1  N2  N3  N4  N5  N6  N7  N8  N9
#   O0  O1  O2  O3  O4  O5  O6  O7  O8  O9
# P0  P1  P2  P3  P4  P5  P6  P7  P8  P9
#   Q0  Q1  Q2  Q3  Q4  Q5  Q6  Q7  Q8  Q9
# R0  R1  R2  R3  R4  R5  R6  R7  R8  R9
#   S0  S1  S2  S3  S4  S5  S6  S7  S8  S9
# T0  T1  T2  T3  T4  T5  T6  T7  T8  T9
#   U0  U1  U2  U3  U4  U5  U6  U7  U8  U9
# V0  V1  V2  V3  V4  V5  V6  V7  V8  V9
#   W0  W1  W2  W3  W4  W5  W6  W7  W8  W9
# X0  X1  X2  X3  X4  X5  X6  X7  X8  X9
#   Y0  Y1  Y2  Y3  Y4  Y5  Y6  Y7  Y8  Y9
# Z0  Z1  Z2  Z3  Z4  Z5  Z6  Z7  Z8  Z9
