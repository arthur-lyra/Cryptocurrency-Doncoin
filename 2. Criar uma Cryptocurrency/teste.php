@startuml Blockchain

!define BLOCKCHAIN_NODE class {
  - id: int
  - data: string
  - previous_hash: string
  - nonce: int
  + calculate_hash(): string
}

!define BLOCKCHAIN class {
  - chain: List<BLOCKCHAIN_NODE>
  + add_node(node: BLOCKCHAIN_NODE): void
}

class BLOCKCHAIN_NODE {
  - id: int
  - data: string
  - previous_hash: string
  - nonce: int
  + calculate_hash(): string
}

class BLOCKCHAIN {
  - chain: List<BLOCKCHAIN_NODE>
  + add_node(node: BLOCKCHAIN_NODE): void
}

BLOCKCHAIN_NODE o-- BLOCKCHAIN_NODE: previous_hash
BLOCKCHAIN_NODE --> "1" BLOCKCHAIN: contains
BLOCKCHAIN -down-> BLOCKCHAIN_NODE: "n" chain

@enduml
