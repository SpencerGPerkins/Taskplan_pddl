(define (problem install-multiple-wires)
  (:domain robot-arm)
  (:objects
    arm1 arm2 - robot
    red_wire blue_wire green_wire black_wire yellow_wire - wire
    power_supply_1 power_supply_2 power_supply_3 power_supply_4 power_supply_5 power_supply_6 power_supply_7 power_supply_8 power_supply_9 table power_supply - location
  )
  (:init
    (arm-empty arm1)
    ;(on red_wire table)
    (on blue_wire table)
    (on green_wire table)
    (on black_wire table)
    (on yellow_wire table)
    ;(available red_wire)
    (inserted red_wire power_supply_7)
    (lockstate)
    (available blue_wire)
    (available green_wire)
    (available black_wire)
    (available yellow_wire)
    (is-arm2 arm2)
    (is-arm1 arm1)
    ;if there is "inserted", add (lockstate)
    ;if the wire is on the table, add(available wire)
  )
  (:goal
    (and
    (locked red_wire power_supply_7)
    (locked blue_wire power_supply_7)
    )
  )
)
