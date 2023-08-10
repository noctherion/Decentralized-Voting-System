# Decentralized Voting System

A voting application where users can cast their votes for different candidates, and the results are recorded on the blockchain in a transparent and tamper-resistant manner:


__Explanation:__

 - The contract contains two structs: Candidate to represent candidate information and Voter to store voter data.
 - The ```onlyOwner``` modifier ensures that only the contract owner can execute certain functions like starting or stopping voting and registering candidates or voters.
 - The ```onlyRegisteredVoter``` modifier restricts some functions to be executed only by registered voters.
 - The ```onlyDuringVotingPeriod``` modifier ensures that voting-related functions can only be called when voting is active.
 - The ```startVoting``` and ```stopVoting``` functions control the voting period, and candidates can be registered only before voting starts.
 - The ```registerCandidate``` function allows the contract owner to add candidates to the election.
 - The ```registerVoter``` function enables the contract owner to register voters.
 - The ```vote``` function allows registered voters to cast their votes for a specific candidate.
 - The ```getWinner``` function determines the candidate with the highest votes after voting is stopped.

__Note:__ Please note that this is a basic implementation of a decentralized voting system, and more sophisticated security features and mechanisms should be added in a real-world application to ensure fairness and integrity. Also, consider gas costs when deploying such a contract on the Ethereum blockchain, as each voter registration and candidate nomination will consume gas.
