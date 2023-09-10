// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint256 votedCandidateId;
    }

    address public owner;
    bool public votingActive;

    uint256 public numCandidates;
    uint256 public numVoters;
    mapping(uint256 => Candidate) public candidates;
    mapping(address => Voter) public voters;

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    modifier onlyRegisteredVoter() {
        require(voters[msg.sender].isRegistered, "You are not a registered voter");
        _;
    }

    modifier onlyDuringVotingPeriod() {
        require(votingActive, "Voting is not active");
        _;
    }

    constructor() {
        owner = msg.sender;
        votingActive = false;
    }

    function startVoting() public onlyOwner {
        require(numCandidates > 0, "No candidates registered");
        votingActive = true;
    }

    function stopVoting() public onlyOwner {
        votingActive = false;
    }

    function registerCandidate(string memory _name) public onlyOwner {
        require(!votingActive, "Cannot register candidates during voting");
        numCandidates++;
        candidates[numCandidates] = Candidate(numCandidates, _name, 0);
    }

    function registerVoter(address _voterAddress) public onlyOwner {
        require(!votingActive, "Cannot register voters during voting");
        require(!voters[_voterAddress].isRegistered, "Voter already registered");
        numVoters++;
        voters[_voterAddress].isRegistered = true;
    }

    function vote(uint256 _candidateId) public onlyRegisteredVoter onlyDuringVotingPeriod {
        require(!voters[msg.sender].hasVoted, "You have already voted");
        require(_candidateId > 0 && _candidateId <= numCandidates, "Invalid candidate ID");

        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedCandidateId = _candidateId;
        candidates[_candidateId].voteCount++;
    }

    function getWinner() public view returns (string memory) {
        require(!votingActive, "Voting is still active");

        uint256 maxVotes = 0;
        uint256 winningCandidateId = 0

        for (uint256 i = 1; i <= numCandidates; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winningCandidateId = i;
            }
        }

        return candidates[winningCandidateId].name;
    }
}
