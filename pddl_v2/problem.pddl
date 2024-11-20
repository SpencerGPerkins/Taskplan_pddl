(define (problem install-multiple-wires)
  (:domain robot-arm)
  (:objects
    arm1 arm2 - robot
    red_wire blue_wire green_wire black_wire yellow_wire - wire
    power_supply_1 power_supply_2 power_supply_3 power_supply_4 power_supply_5 power_supply_6 power_supply_7 power_supply_8 power_supply_9 - location
    table - workspace
  )
  (:init
    (arm-empty arm1)
    (on blue_wire table)
    (on green_wire table)
    (on black_wire table)
    (on yellow_wire table)
    (is-arm2 arm2)
    (is-arm1 arm1)
    (= (total-cost) 0)
  )
  )
   ;; Goal with preferences
  (:goal
    (and
      ;; Hard goals: All wires must be locked in specific positions
      (locked yellow_wire position1)
      (locked blue_wire position2)
      (locked black_wire position3)
      (locked red_wire position4)

      ;; Preferences for locking order
      (preference lock-order1 (before (locked yellow_wire position1) (locked blue_wire position2)))
      (preference lock-order2 (before (locked black_wire position3) (locked red_wire position4)))
      (preference lock-order3 (sometime-after (locked blue_wire position2) (and (locked yellow_wire position1)
                                                                                (locked black_wire position3)
                                                                                (locked red_wire position4))))
    )
  )

  ;; Preference costs (optional to weigh each preference)
  (:init
    (= (preference-cost lock-order1) 5)
    (= (preference-cost lock-order2) 5)
    (= (preference-cost lock-order3) 10)
  )

  ;; Metric to minimize total cost and encourage preference satisfaction
  (:metric minimize (+ (total-cost) (* 5 (num-violated-preferences))))
