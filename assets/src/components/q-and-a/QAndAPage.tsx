import React, {useRef} from 'react';

import {Box} from 'theme-ui';

const QAndAPage: React.FC = () => {
  // Create a ref to the iframe element
  const iframeRef = useRef<HTMLIFrameElement | null>(null);
  return (
    <Box
      sx={{
        flex: 1,
        overflow: 'hidden',
      }}
    >
      <iframe
        ref={iframeRef}
        src="https://home.agh.edu.pl/~boryczko/"
        width="100%"
        height="100%"
        title="Test Iframe"
      ></iframe>
    </Box>
  );
};

export default QAndAPage;
