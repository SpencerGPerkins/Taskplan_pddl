(define (domain test-RL)
  (:requirements :typing :equality :strips)

  (:types
    wire robot location workspace ; location is the place that wire can be locked, work space means that the place robotic arm can pickup the wire.
  )

  (:predicates
    (holding ?wire - wire)
    (on ?wire - wire ?space - workspace)
    (locked ?wire - wire ?loc - location)
    (inserted ?wire - wire ?loc - location)
    (arm-empty ?arm - robot)
    (is-arm2 ?arm - robot)
    (is-arm1 ?arm - robot)
    (move-right ?arm - robot)
    (move-left ?arm - robot)
    (move-forward ?arm - robot)
    (move-backward ?arm - robot)
    (move-home ?arm - robot)
    (find ?wire - wire)  
  )

  (:action pickup
    :parameters
      (?arm - robot
       ?wire - wire
       ?space - workspace)
    :precondition
      (and
        (on ?wire ?space)
        (arm-empty ?arm)
        (find ?wire)
      )
    :effect
      (and
        (not (on ?space ?wire))
        (holding ?wire)
        (not (arm-empty ?arm))
      )
  )

  (:action putdown
    :parameters
      (?arm - robot
       ?wire - wire
       ?space - workspace)
    :precondition
      (and
        (holding ?wire)
        (is-arm1 ?arm)
        (find ?wire)
      )
    :effect
      (and
        (on ?wire ?space)
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
        (find ?wire)
      )
    :effect
      (and
        (locked ?wire ?loc)
        (arm-empty arm1)
        (not(inserted ?wire ?loc))
      )
  )

  (:action insert
    :parameters
      (?arm - robot
       ?wire - wire
       ?loc - location)
    :precondition
      (and
        (find ?wire)
        (holding ?wire)
        (is-arm1 ?arm)
      )
    :effect
      (and
        (inserted ?wire ?loc)
        (not (holding ?wire))
      )
  )

  (:action find
    :parameters
      (?wire - wire)
    :precondition
      (and)
    :effect
      (and
        (find ?wire)
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