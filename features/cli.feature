#encoding: utf-8
@client
Feature: AHAB Command-Line Interface

  Scenario: No ahab.json
    Given the file "ahab.json" does not exist
    When I run `ahab fetch`
    Then the exit status should be 1
    And the output should contain "Could not find ahab.json"

  Scenario: Empty ahab.json
    Given a file named "ahab.json" with:
    """
    {}
    """
    When I run `ahab fetch`
    Then the exit status should be 0
    And the output should contain "Fetched 0 assets"

  Scenario: Fetch asset via URL; infer filename
    Given a file named "ahab.json" with:
    """
    { "assets": [ { "url": "http://example.com/my/asset.txt" } ] }
    """
    And the URL "http://example.com/my/asset.txt" returns:
    """
    content from URL
    """
    When I run `ahab fetch`
    Then the exit status should be 0
    And the file "vendor/assets/asset.txt" should contain:
    """
    content from URL
    """
    And the output should contain "Fetched 1 asset"

  Scenario: Fetch asset via URL; specify filename
    Given a file named "ahab.json" with:
    """
    {
      "assets": [
        {
          "url": "http://example.com/my/asset.txt",
          "filename": "my-asset.txt"
        }
      ]
    }
    """
    And the URL "http://example.com/my/asset.txt" returns:
    """
    content from URL
    """
    When I run `ahab fetch`
    Then the exit status should be 0
    And the file "vendor/assets/my-asset.txt" should contain:
    """
    content from URL
    """
    And the output should contain "Fetched 1 asset"

  Scenario: Fetch asset via URL; cannot infer filename
    Given a file named "ahab.json" with:
    """
    { "assets": [ { "url": "http://example.com" } ] }
    """
    When I run `ahab fetch`
    Then the exit status should be 1
    And the output should contain "Cannot infer filename from http://example.com"

  Scenario: Error fetching from URL
    Given a file named "ahab.json" with:
    """
    { "assets": [ { "url": "http://example.com/my/asset.txt" } ] }
    """
    And the URL "http://example.com/my/asset.txt" returns a 404 error
    When I run `ahab fetch`
    Then the exit status should be 1
    And the output should contain "Error fetching http://example.com/my/asset.txt"
