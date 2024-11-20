(define (problem install-two-wires)
    (:domain test-RL)
    (:objects
        arm1 - robot
        arm2 - robot
        red_wire - wire
        blue_wire - wire
        power_supply_1 - location
        power_supply_2 - location
        table - workspace
    )

    (:init
        (arm-empty arm1)
        (on red_wire table)
        (on blue_wire table)
        (is-arm2 arm2)
        (is-arm1 arm1)
    )

    (:goal 
        (and
            (locked red_wire power_supply_2)
            (locked blue_wire power_supply_1)
        )
    )
)