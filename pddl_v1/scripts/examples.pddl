(:action pickup
    :parameters (?arm ?object ?location)
    :precondition (and (at ?object ?location) (free ?arm))
    :effect (and (holding ?arm ?object) (not (at ?object ?location)) (not (free ?arm)))
    :cost 10)  ;; Explicit action cost


(:goal
  (and
    (preference p1 (sometime (at ?location ?target)))
    (preference p2 (always (not (blocked ?arm)))))
)

(:init
  (= (preference-cost p1) 5)
  (= (preference-cost p2) 3)
  (= (action-cost pickup) 10)
  (= (action-cost move) 5))
)

(:metric minimize (total-cost))





(define (problem wiring-problem)
  (:domain wiring-domain)
  
  ;; Define objects
  (:objects
    arm1 arm2 - arm
    red_wire yellow_wire blue_wire black_wire - object
    table power_supply - location
    position1 position2 position3 position4 - position
  )

  ;; Initial state
  (:init
    (at yellow_wire table)
    (at blue_wire table)
    (at black_wire table)
    (at red_wire table)
    (free arm1)
    (free arm2)
    (= (total-cost) 0)
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
)
)
