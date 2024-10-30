(define (domain robot-arm)
  (:requirements :typing)

  (:types
    wire robot location
  )

  (:predicates
    (holding ?wire - wire)
    (arm-empty ?arm - robot)
    (available ?wire - wire)
    (on ?wire - wire ?loc - location)
    (locked ?wire - wire ?loc - location)
    (inserted ?wire - wire ?loc - location)
    (move-right ?arm - robot)
    (move-left ?arm - robot)
    (move-forward ?arm - robot)
    (move-backward ?arm - robot)
    (move-home ?arm - robot)
    (is-arm2 ?arm - robot)
    (is-arm1 ?arm - robot)
  )

  (:action pickup
    :parameters
      (?arm - robot
       ?wire - wire)
    :precondition
      (and
        (available ?wire)
        (arm-empty ?arm)
      )
    :effect
      (and
        (not (available ?wire))
        (holding ?wire)
        (not (arm-empty ?arm))
      )
  )

  (:action putdown
    :parameters
      (?arm - robot
       ?wire - wire
       ?loc - location)
    :precondition
      (and
        (holding ?wire)
        (is-arm1 ?arm)
      )
    :effect
      (and
        (on ?wire ?loc)
        (arm-empty ?arm)
        (not (holding ?wire))
      )
  )

  (:action lock
    :parameters
      (?arm - robot
       ?wire - wire
       ?loc - location)
    :precondition
      (and
        (inserted ?wire ?loc)
        (is-arm2 ?arm)
      )
    :effect
      (locked ?wire ?loc)
  )

  (:action insert
    :parameters
      (?arm - robot
       ?wire - wire
       ?loc - location)
    :precondition
    (and
      ;(holding ?arm ?wire)
      (holding ?wire)
      (is-arm1 ?arm)
    )
    :effect
      (and
        (inserted ?wire ?loc)
        (arm-empty ?arm)
        (not (holding ?wire))
      )
  )

  (:action move-forward
    :parameters (?arm - robot)
    :precondition (and) 
    :effect (and (move-forward ?arm))
  )

  (:action move-backward
    :parameters (?arm - robot)
    :precondition (and) 
    :effect (and (move-backward ?arm))
  )

  (:action move-right
    :parameters (?arm - robot)
    :precondition (and) 
    :effect (and (move-right ?arm))
  )

  (:action move-left
    :parameters (?arm - robot)
    :precondition (and) 
    :effect (and (move-left ?arm))
  )

  (:action move-home
    :parameters (?arm - robot)
    :precondition (and) 
    :effect (and (move-home ?arm))
  )
  
)
