import React, {useRef} from 'react';
import {Box} from 'theme-ui';

const QAndAPage: React.FC = () => {
  const iframeRef = useRef<HTMLIFrameElement | null>(null);

  const getAccessToken = () => {
    if (iframeRef.current) {
      const iframeContentWindow = iframeRef.current.contentWindow;

      if (iframeContentWindow) {
        const accessToken = window.localStorage.getItem('accessToken');
        return accessToken;
      }
    }
    return '';
  };

  return (
    <Box
      sx={{
        flex: 1,
        overflow: 'hidden',
      }}
    >
      <iframe
        ref={iframeRef}
        src={`http://localhost:8080/model_settings?token=${getAccessToken()}`}
        width="100%"
        height="100%"
        title="Model Iframe"
      ></iframe>
    </Box>
  );
};

export default QAndAPage;
