## Overview

Flow: <https://miro.com/app/board/uXjVMXyfa-o=/?moveToWidget=3458764557422793722&cot=14>

#### New Variables

```javascript
  address externalContract;
  EnumerableMap.AddressToUintMap private allocationTracker;
  uint256 totalAllocations;

  struct Application {
      address identityId;
      ApplicationStatus status;
      MetaPtr metaPtr;
  }

// create a mapping of applicationId to application status
mapping(address => Application) applications;

// some means to track votes casted by user
mapping(address => uint32) voteCounter;
```

#### New Functions

Functions around updating constructor arguments.

```javascript
function updateVotingStart(uint64 _votingStart) external {}
function updateVotingEnd(uint64 _votingEnd) external {}
function updateApplicationStart(uint64 _applicationStart) external {}
function updateApplicationEnd(uint64 _applicationEnd) external {}
```

Functions around actual functionality

```javascript
function reviewApplications(bytes[] memory _data) external {
    // decode data to get identity id and status
    // update application status
}
```

### Open Questions

- Are we allowing updating the allowed list of voters?
- how to deal with votes of voters which will be removed from whitelist
- can the external contract be changed? 

## Variations

The allocation strategy can be customized for different usecase

- Application Gating
  - update initialize() (if applicable)
  - update applyToPool to invoke contracts to check gating
- Allocation Gating
  - update initialize() (if applicable)
  - update allocate to invoke contracts to check gating
- Not using registry. AKA no indentityId
  - in these cases, an applicationID would have to be generated by the AllocationStrategy
